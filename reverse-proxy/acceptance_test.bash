#!/bin/bash
# This is a test program for calculator

test $(curl --silent -X GET http://localhost:8090/sum?a=1\&b=2) -eq 3 && \
test $(curl --silent -X GET http://localhost:8090/sum?a=1000000\&b=2000000) -eq 3000000 && \
test $(curl --silent -X GET http://localhost:8090/sum?a=\-1\&b=\-2) -eq \-3 && \
test $(curl --silent -X GET http://localhost:8090/sum?a=3\&b=4) -ne 3 

if [ $? -eq 0 ] 
then 
    echo "Test Success"
    exit 0
else 
    echo "Test Fail"
    exit 1
fi

