mc_command() {
        COMMAND=$1
        echo $COMMAND | mcrcon --password "password" 127.0.0.1
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
        
        aws s3 sync /opt/minecraft/ s3://"$BUCKET_NAME"/saves/ --exclude "/opt/minecraft/logs/*" --exclude "/opt/minecraft/libraries/*" --exclude "/opt/minecraft/bin/*" --exclude "/opt/minecraft/*.log" --exclude "/opt/minecraft/installer.jar" --exclude "/opt/minecraft/server.jar"
}

mc_backup() {
        mc_say "Backup"
        mc_stop
        systemctl start minecraft
}