#!/bin/bash

# get the URL of the current Astronomy Picture of the Day (APOD)
clientId=$(curl -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.14/register | jq -r '.clientId')
clientSecret=$(curl -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.14/register | jq -r '.clientSecret')
# get just the image name from the URL
echo $clientId
echo $clientSecret

encoded=$(echo -ne $clientId:$clientSecret | base64)
echo $encoded

# get access token
accessToken=$(curl -k -d "grant_type=password&username=admin&password=admin&scope=apim:api_view apim:api_create apim:api_publish" -H "Authorization: Basic $encoded" https://localhost:9443/oauth2/token | jq -r '.access_token')

echo "======= access token =========="
echo $accessToken

################################CREATE API PRODUCT ############################
api_product_payload(){
    cat<<EOF
{
  "name": "CalculatorAPIProduct",
  "description": "A calculator API Product that supports basic operations",
  "provider": "admin",
  "thumbnailUri": "/api-products/01234567-0123-0123-0123-012345678901/thumbnail",
  "description": "",
  "visibility": "PUBLIC",
  "policies": ["Unlimited"],
  "visibleTenants": [
    "string"
  ],
  "additionalProperties": {
    "additionalProp1": "string",
    "additionalProp2": "string",
    "additionalProp3": "string"
  },
  "businessInformation": {
    "businessOwner": "businessowner",
    "businessOwnerEmail": "businessowner@wso2.com"
  },
  "apis": [
    {
      "name": "CalculatorAPI",
      "apiId": "0eafdb42-d7f1-40bb-85ab-8973d5926df7",
      "operations": [
        {
          "id": "postapiresource",
          "target": "/add",
          "verb": "POST",
          "authType": "string",
          "throttlingPolicy": "Unlimited",
          "scopes": ["string"]
        }
      ]
    }
  ]
}

EOF
}

create_api_product() {
    local api_product_id=$(curl -k -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json" -X PUT -d "$(api_product_payload)" https://localhost:9443/api/am/publisher/v1.0/api-products/ac3a2a8b-8b85-4e84-a11f-b2b6eba6d928 | jq -r '.id')
    echo $api_product_id
}
api_product_id=$(create_api_product)

echo " API Product: " $api_product_id