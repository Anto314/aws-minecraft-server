 #! /bin/bash

PERIOD=$2
mc_command() {
        COMMAND=$1
        echo $COMMAND | mcrcon -p password
}

mc_say() {
        MESSAGE=$1
        mc_command "say $MESSAGE"
}

mc_waiting(){
        TOTAL_TIME=$1
        let "ITERATION=TOTAL_TIME/SLEEP_TIME"
        for ((i=0;i<"$ITERATION";i++))
        do
                let "REMAINING=TOTAL_TIME-i*SLEEP_TIME"
                mc_say "Remaining $REMAINING Seconds Before Server Stop"
                sleep "$PERIOD"
        done
}

mc_stop_server() {
        INSTALL_PATH="$1"
        BUCKET_NAME="$2"
        ARCHIVE_NAME="$INSTALL_PATH/world.zip"
        mc_say "Stopping the Server"
        mc_command "save-off"
        mc_command "save-all"
        mc_command "save-on"
        mc_command "stop"
        zip -r "$ARCHIVE_NAME" "$INSTALL_PATH/world/"
        aws s3 cp "$ARCHIVE_NAME" s3://$BUCKET_NAME/world.zip
}

main(){
        TOTAL_TIME=$1
        INSTALL_PATH="$3"
        BUCKET_NAME="$4"
        mc_waiting "$TOTAL_TIME" "$PERIOD"
        mc_stop_server "$INSTALL_PATH" "$BUCKET_NAME"
}

# Calling Main
main $1 $2 $3 $4