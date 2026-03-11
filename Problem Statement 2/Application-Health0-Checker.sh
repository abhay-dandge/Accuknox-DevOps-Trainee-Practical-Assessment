#!/bin/bash

read -p "Enter application URL: " url
status=$(curl -s -o /dev/null -w "%{http_code}" $url)
echo "HTTP Status Code: $status"
if [ "$status" -eq 200 ]; then
    echo "Application Status: UP"
else
    echo "Application Status: DOWN"
fi
