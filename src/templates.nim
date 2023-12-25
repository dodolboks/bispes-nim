# Import HappyX
import
  happyx

# Declare template folder
templateFolder("templates")

proc renderLogin*(ulangi: bool, telp: string, domain: string): string =
  renderTemplate("login_wa.html")

# proc renderIndex*(): string =
#   renderTemplate("index.html")
# 
proc renderOTP*(validitas: bool, telp: string): string =
   renderTemplate("otp.html") 
# 
proc renderHome*(sessionID: string): string =
   renderTemplate("500.html") 
# 
proc render500*(): string =
   renderTemplate("500.html") 
# 
# proc render404*(): string =
#   renderTemplate("404.html") 
# 
