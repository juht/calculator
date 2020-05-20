#!/bin/bash
# This is a test program for calculator

test $(curl --silent -X GET http://docker:8090/sum?a=1\&b=2) -eq 3 && \
test $(curl --silent -X GET http://docker:8090/sum?a=1000000\&b=2000000) -eq 3000000 && \
test $(curl --silent -X GET http://docker:8090/sum?a=\-1\&b=\-2) -eq \-3 && \
test $(curl --silent -X GET http://docker:8090/sum?a=1\&b=2) -ne 4 
