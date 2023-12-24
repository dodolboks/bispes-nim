# Import HappyX
import
  happyx

# Declare template folder
templateFolder("templates")

model MyOTP:
  phone: string
  email: string
  verify: string


proc renderLogin*(): string =
  renderTemplate("login.html")

proc renderIndex*(): string =
  renderTemplate("index.html")

proc renderOTP*(): string =
  renderTemplate("otp.html") 

proc renderHtml*(nama: string): string =
  const nama = "index.html"
  renderTemplate(nama) 

proc render500*(): string =
  renderTemplate("500.html") 

proc render404*(): string =
  renderTemplate("404.html") 
