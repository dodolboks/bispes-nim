import json
import flatdb

var store = newFlatDb("store.json", false)
var userDb = newFlatDb("user.json", false)
var trxDb = newFlatDb("trx.json", false)
var member = newFlatDb("trx.json", false)
var produk = newFlatDb("trx.json", false)

discard store.load()
discard userDb.load()
discard trxDb.load()

# Your JSON data as a string

proc getQuery*(q1: string, q2: string): seq[JsonNode] = 
  let queryd = store.queryDb(findDb(q1, q2))
  result = queryd 

proc getUser*(q1: string, q2: string): seq[JsonNode] = 
  let queryd = userDb.queryDb(findDb(q1, q2))
  result = queryd 

proc newUser*(data: JsonNode): bool = 
  dbs.append(data)
  result = true