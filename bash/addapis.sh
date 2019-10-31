#!/bin/bash

# get the URL of the current Astronomy Picture of the Day (APOD)
clientId=$(curl -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.15/register | jq -r '.clientId')
clientSecret=$(curl -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.15/register | jq -r '.clientSecret')
# get just the image name from the URL
echo $clientId
echo $clientSecret

encoded=$(echo -ne $clientId:$clientSecret | base64)
echo $encoded

# get access token
accessToken=$(curl -k -d "grant_type=password&username=admin&password=admin&scope=apim:api_view apim:api_create apim:api_publish" -H "Authorization: Basic $encoded" https://localhost:9443/oauth2/token | jq -r '.access_token')

echo "======= access token =========="
echo $accessToken

declare -a tags=("weather" "finance" )
for tag in "${tags[@]}"
do
    for i in {1..22}
    do
        echo $tag
        apiId=$(curl -k -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json" -X POST --data-binary '{"name":"'$tag'API'$i'","version":"1.0.0","context":"'$tag'API'$i'","tags":["'$tag'"],"isDefaultVersion":false,"gatewayEnvironments":["Production and Sandbox"],"transport":["http","https"],"visibility":"PUBLIC","endpointConfig":{"endpoint_type":"http","sandbox_endpoints":{"url":"http://apiendpoint"},"production_endpoints":{"url":"http://apiendpoint"}},"policies":["Unlimited"]}' https://localhost:9443/api/am/publisher/v1.0/apis  | jq -r '.id')
        echo "==============================================================="
        echo $apiId


        ## publishing
        echo "===========================publishing===================================="
        publishState=$(curl -k -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json" -X POST "https://localhost:9443/api/am/publisher/v1.0/apis/change-lifecycle?action=Publish&apiId=$apiId" -H "accept: application/json")
    done
done

