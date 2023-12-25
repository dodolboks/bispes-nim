import json
import flatdb

var dbs = newFlatDb("testdb.db", false)
var userDb = newFlatDb("user.json", false)

discard dbs.load()
discard userDb.load()

# Your JSON data as a string

proc getQuery*(q1: string, q2: string): seq[JsonNode] = 
  let queryd = dbs.queryDb(findDb(q1, q2))
  result = queryd 

proc getUser*(q1: string, q2: string): seq[JsonNode] = 
  let queryd = userDb.queryDb(findDb(q1, q2))
  result = queryd 

proc saveQuery*(data: JsonNode): bool = 
  dbs.append(data)
  result = true