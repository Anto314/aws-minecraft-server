mc_command() {
        COMMAND=$1
        echo $COMMAND | mcrcon -p password
}

mc_say() {
        MESSAGE=$1
        mc_command "say $MESSAGE"
}

mc_waiting(){
        let "ITERATION=STOP_WAIT_TIME/PERIOD"
        for ((i=0;i<"$ITERATION";i++))
        do
                let "REMAINING=STOP_WAIT_TIME-i*PERIOD"
                mc_say "Remaining $REMAINING Seconds Before Server Stop"
                sleep "$PERIOD"
        done
}

mc_stop_server() {
        ARCHIVE_NAME="$INSTALL_PATH/world.zip"
        mc_say "Stopping the Server"
        mc_command "save-off"
        mc_command "save-all"
        mc_command "save-on"
        mc_command "stop"
        zip -r "$ARCHIVE_NAME" "$INSTALL_PATH/world/"
        aws s3 cp "$ARCHIVE_NAME" s3://$BUCKET_NAME/world.zip
}
