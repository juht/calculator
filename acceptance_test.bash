#!/bin/bash
test $(curl --silent -X GET http://docker:8090/sum?a=1\&b=2) -eq 3 && \
test $(curl --silent -X GET http://docker:8090/sum?a=2\&b=\-2) -eq 0 && \
test $(curl --silent -X GET http://docker:8090/sum?a=1000000\&b=2000000) -eq 3000000 && \
test $(curl --silent -X GET http://docker:8090/sum?a=\-1\&b=\-2) -eq \-3 && \
test $(curl --silent -X GET http://docker:8090/sum?a=4\&b=5) -ne 3 
