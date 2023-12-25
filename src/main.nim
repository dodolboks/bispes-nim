import happyx
import templates
import lib/[aksesdb]
import std/[strutils, json, strformat, random, oids]
import redis
import limdb


model MyOTP:
  telp: string
  email: string
  verify: string


# Serve at http://127.0.0.1:5000
serve("127.0.0.1", 5000):
  let r = redis.open()
  let db = initDatabase("myDb")

  # on GET HTTP method at http://127.0.0.1:5000/TEXT
  # get "/{title:string}":
  #  req.answerHtml render(title)
  # on any HTTP method at http://127.0.0.1:5000/public/path/to/file.ext
  # get "/":
    # mending cek kukis
    # echo req.headers
  #  req.answerHtml: renderIndex()

  get "/web/login":
    req.answerHtml: renderLogin(false, "", domain="bispes.me")

  #get "/login/verify/":
  #  req.answerHtml: renderOTP()
  post "/web/login/wa/[m:MyOTP:urlencoded]":
    let phone = m.telp
    try:
      #echo req.headers
      #echo req.getSession
      randomize()
      let sessionID =  inCookies["sessionid"]
      var nums: int = rand(10000..99999)
      echo nums
      let keyOtp: string = "OTP:Catetdulu:" & phone
      let valueOtp = $genOid() & "-" & $nums
      discard r.setex(keyOtp, 200, valueOtp)
      discard r.setex($sessionID, 200, phone)
      # cookies.add(setCookie("bestFramework", "HappyX!", secure = true, httpOnly = true))
      req.answerHtml: renderOTP(true, phone)
    except:
      let msg = getCurrentExceptionMsg()
      echo "Got exception on OTP Login with message ", msg  
      req.answerHtml: render500()

  post "/web/login/otp/verify/[m:MyOTP:urlencoded]":
    # echo req.headers
    {.gcsafe.}:
      try:
        let verify = m.verify
        echo verify
        let sessionID =  inCookies["sessionid"]
        echo sessionID
        let phone = r.get(sessionID)
        echo phone
        echo $verify
        let keyOtp = "OTP:Catetdulu:" & phone
        echo $keyOtp
        let getOtp = r.get(keyOtp)  
        echo $getOtp
        if len(getOtp) < 3:
          req.answerHtml: renderOTP(true, phone)

        let uuid = getOtp.split("-")[0]
        let keyHash = getOtp.split("-")[1]
        if keyHash == verify:
          # buat user jika belum ada
          let ccUser = getUser("phone","085797522261")
          echo ccUser
          # let getUser = true
          let name = fmt"user-{phone}"

          if db.hasKey(name):
            echo("user ada")
            # let getUser2 = dbUser[keyHash]
            req.answerHtml: renderHome("")
          else:
            var jsonNode = %*{"phone": $phone, "sessionId": sessionID}
            db[name] = $jsonNode
            # discard userDb.append(jsonNode)
            # dbUser[uuid] = newUser.toJson()
            req.answerHtml: renderHome(sessionID)

        else:
          req.answerHtml: renderOTP(true, phone)

      except:
        let
          e = getCurrentException()
          msg = getCurrentExceptionMsg()
        echo "Got exception ", repr(e), " with message ", msg  
        req.answerHtml: render500()    

  get "/readflat":
    {.gcsafe.}:
      let dd = getQuery("foo", "baa")
      var jsonNode = %*{"response": "success", "data": dd}
      return jsonNode

  staticDir "static"
