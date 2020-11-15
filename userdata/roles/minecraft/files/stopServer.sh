 #! /bin/bash
. /opt/minecraft/minecraft.env
. /opt/minecraft/minecraft_lib.sh

main(){
        mc_waiting
        mc_stop_server
}

# Calling Main
main