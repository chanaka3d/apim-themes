#!/bin/bash
declare -a tagsArray=("java" "spring" "python" "SOA" "SOAP" "scalable" "asw" "lamda" "bucket" "s3" "react" "babel" "router" "webpack" "npm" "node" "wso2" "ballerina" "websocket" "gateway")
# bash generate random 32 character alphanumeric string (lowercase only)
apiname=$(head /dev/urandom | LC_ALL=C  tr -dc A-Za-z0-9 | head -c 13)

echo $apiname

tagcount=$(jot -r 1  0 20)

echo $tagcount

create_and_publish () {
    for ((i=1; i<=$1; i++))
    do
        echo "tagging with ${tagsArray[0]} $1 times"

    done
} 

create_and_publish $tagcount