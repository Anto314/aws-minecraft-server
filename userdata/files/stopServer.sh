 #! /bin/bash

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
        SLEEP_TIME=$2
        let ITERATION=TOTAL_TIME/SLEEP_TIME
        for ((i=0;i<$ITERATION:i++))
        do
                let REMAINING=TOTAL_TIME-ITERATION*SLEEP_TIME
                mc_say "Remaining $REMAINING Seconds Before Server Stop"
        done
}

mc_stop_server() {
        mc_say "Stopping the Server"
        mc_command "save-all"
        mc_command "stop"
}

main(){
        TOTAL_TIME=$1
        PERIOD=$2
        mc_waiting "$TOTAL_TIME" "$PERIOD"
        mc_stop_server
}

# Calling Main
main $1 $2 $3