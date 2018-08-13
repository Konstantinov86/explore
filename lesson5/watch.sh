#!/bin/bash
CATALINA_HOME='/opt/apache-tomcat-8.5.5'
MAIL_TO='example@gmail.com'
HOST=$(hostname)
STATUS=`netstat -nap | grep 8080 | awk '{print $6}'`
if [ "$STATUS" = "LISTEN" ]; then
    echo "TOMCAT IS RUNNING"
elif [ "$STATUS" = "" ];  then 
    echo "TOMCAT IS NOT RUNNING ON PORT 8080 ON $HOST"
    ## Run tomcat ##
    #cd $CATALINA_HOME/bin
    #./startup.sh
fi
RESULT=`netstat -nap | grep 8080 | awk '{print $6}' | wc -l`
if [ "$RESULT" = 0 ]; then
    echo "FAILED TO START TOMCAT ON $HOST" | mail -s "ERROR WHEN TRIED TO START TOMCAT AFTER CRASH ON $HOST" $MAIL_TO
elif [ "$RESULT" != 0 ]; then
    echo "TOMCAT WORKING"
fi