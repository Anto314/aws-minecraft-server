. /opt/minecraft/minecraft.env
. /opt/minecraft/minecraft_lib.sh

systemctl stop minecraft
systemctl start minecraft

aws sns publish --topic-arn "$SNS_TOPIC_ARN" --message "Server Up" --subject 'Server Minecraft est pret!'