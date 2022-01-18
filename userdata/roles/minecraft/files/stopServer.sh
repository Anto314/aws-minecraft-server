 #! /bin/bash
. /opt/minecraft/bin/minecraft.env
. /opt/minecraft/bin/minecraft_lib.sh

main(){
        mc_waiting
        mc_stop_server
}

# Calling Main
main