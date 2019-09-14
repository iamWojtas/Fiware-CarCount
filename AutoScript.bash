curl -iX POST \
  'http://localhost:1026/v2/entities' \
  -H 'Content-Type: application/json' \
  -d '
{
   "id": "urn:ngsi-ld:Segment:001",
   "type": "Segment"
 }'

curl -iX POST \
  'http://localhost:1026/v2/entities' \
  -H 'Content-Type: application/json' \
  -d '
{
    "id": "urn:ngsi-ld:Crossing:002",
    "type": "Crossing",
    "location": {
        "type": "geo:json",
        "value": {
             "type": "Point",
             "coordinates": [-38.737541, -72.588803]
        }
    },
    "name": {
        "type": "Text",
        "value": "Diego Portales / Manuel Bulnes"
    }
}'

curl -iX POST \
  'http://localhost:1026/v2/entities' \
  -H 'Content-Type: application/json' \
  -d '
{
    "id": "urn:ngsi-ld:Crossing:001",
    "type": "Crossing",
    "location": {
        "type": "geo:json",
        "value": {
             "type": "Point",
             "coordinates": [-38.737359, -72.590131]
        }
    },
    "name": {
        "type": "Text",
        "value": "Diego Portales / Arturo Prat"
    }
}'

curl -iX POST \
  'http://localhost:1026/v2/op/update' \
  -H 'Content-Type: application/json' \
  -d '{
  "actionType":"APPEND",
  "entities":[
    {
      "id":"urn:ngsi-ld:Crossing:001", "type":"Crossing",
      "refSegment": {
        "type": "Relationship",
        "value": "urn:ngsi-ld:Segment:001"
      }
    },
    {
      "id":"urn:ngsi-ld:Crossing:002", "type":"Crossing",
      "refSegment": {
        "type": "Relationship",
        "value": "urn:ngsi-ld:Segment:001"
      }
    } 
 ]
}'

curl -iX POST \
  'http://localhost:4061/iot/services' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /' \
  -d '{
 "services": [
   {
     "apikey":      "4jggokgpepnvsb2uv4s40d59ov",
     "cbroker":     "http://orion:1026",
     "entity_type": "Thing",
     "resource":    "/iot/d"
   }
 ]
}'

curl -iX POST \
  'http://localhost:4061/iot/devices' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /' \
  -d '{
 "devices": [
   {
     "device_id":   "camCar001",
     "entity_name": "urn:ngsi_ld:camCar:001",
     "entity_type": "camCar",
     "timezone":    "Chile, Santiago",
     "attributes": [
       { "object_id": "direction1", "name": "carCount1", "type": "INTEGER" }, 
       { "object_id": "direction2", "name": "carCount2", "type": "INTEGER" } 
     ],
     "static_attributes": [
       { "name":"refSegment", "type": "Relationship", "value": "urn:ngsi-ld:Segment:001"}
     ]
   }
 ]
}'

curl -iX POST \
  'http://localhost:1026/v2/subscriptions' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /' \
  -d '{
  "description": "Notify Cygnus of all context changes",
  "subject": {
    "entities": [
      {
        "idPattern": ".*"
      }
    ]
  },
  "notification": {
    "http": {
      "url": "http://cygnus:5050/notify"
    },
    "attrsFormat": "legacy"
  },
  "throttling": 1
}'

