#/bin/bash

curl -k--cookie-jar cjar --output /dev/null https://sakai.iitd.ac.in/portal/xlogin

curl -k --cookie cjar --cookie-jar cjar \
    --data 'username=foo' \
    --data 'password=bar' \
    --data 'service=https://sakai.iitd.ac.in/portal/xlogin' \
    --data 'loginurl=https://sakai.iitd.ac.in/portal/xlogin' \
    --location \
    --output ~/loginresult.html \
        https://sakai.iitd.ac.in/portal
