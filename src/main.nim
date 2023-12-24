import happyx
import login
import json
import lib/aksesdb

# Serve at http://127.0.0.1:5000
serve("127.0.0.1", 5000):
  # on GET HTTP method at http://127.0.0.1:5000/TEXT
  # get "/{title:string}":
  #  req.answerHtml render(title)
  # on any HTTP method at http://127.0.0.1:5000/public/path/to/file.ext
  get "/":
    # mending cek kukis
    # echo req.headers
    req.answerHtml: renderIndex()

  get "/login":
    req.answerHtml: renderLogin()

  get "/login/verify/":
    req.answerHtml: renderOTP()
  
  get "/readflat":
    {.gcsafe.}:
      let dd = getQuery("foo", "baa")
      var jsonNode = %*{"response": "success", "data": dd}
      return jsonNode

  staticDir "static"
