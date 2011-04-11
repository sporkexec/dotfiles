#!/bin/bash
# Sick of the shitty web interface for university wifi authentication.
# Also the SSL wasn't working in Chromium for a while. Hence, this.
# The url varies depending on the AP, so I did this instrad of something smart.

read -p "Username: " USER
read -s -p "Password: " PASS

URL="https://bak-65-r118-lc1.csub.edu/cgi-bin/login"
PARAMS="cmd=authenticate&user=$USER&password=$PASS"

curl -d "$PARAMS" "$URL"

