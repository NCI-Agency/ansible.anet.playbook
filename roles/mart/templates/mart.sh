#!/bin/sh

SERVICE_NAME=MART
APP_FOLDER={{mart_application_folder}}
PATH_TO_JAR={{mart_application_folder}}/{{mart_installer_file_name}}
PID_PATH_NAME=/tmp/mart-pid
JAVA_OPTIONS="-Dspring.profiles.active=prod"

case $1 in
    run)
        echo "Running $SERVICE_NAME ..."
        cd "$APP_FOLDER"
        java -jar "$JAVA_OPTIONS" $PATH_TO_JAR
    ;;
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            cd "$APP_FOLDER"
            nohup java -jar "$JAVA_OPTIONS" $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup java -jar "$JAVA_OPTIONS" $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    *)
        echo "Usage mart.sh [run|start|stop|restart]"
    ;;
esac
