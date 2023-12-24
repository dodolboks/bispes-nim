import json
import flatdb

var dbs* = newFlatDb("testdb.db", false)
dbs.load()


# Your JSON data as a string
let jsonData = """
{
  "_default": {
    "1": {"int": 1, "char": "a"},
    "2": {"int": 1, "char": "b"},
    "3": {"int": 3, "char": "y"},
    "4": {"int": 4, "char": ["y"]},
    "5": {"gangnam": 4, "chars": ["y"]},
    "6": {"gangnam": 5, "chars": ["y"]}
  }
}
"""

proc getQuery*(q1: string, q2: string): seq[JsonNode] = 
  let queryd = dbs.queryDb(findDb(q1, q2))
  result = queryd 
