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
        ARCHIVE_NAME="save.$FLAVOR.zip"
        mc_say "Stopping the Server"
        sleep "$PERIOD"
        
        mc_command "save-off"
        sleep "$PERIOD"
        
        mc_command "save-all"
        sleep "$PERIOD"
        
        mc_command "save-on"
        sleep "$PERIOD"
        
        mc_command "stop"
        sleep "$PERIOD"
        
}
