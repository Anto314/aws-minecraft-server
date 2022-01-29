. /opt/minecraft/bin/minecraft.env
. /opt/minecraft/bin/minecraft_lib.sh

mc_say "$1"

systemctl stop minecraft


if [ "$?" -eq 0 ]
then
    aws sns publish --topic-arn "$SNS_TOPIC_ARN" --message "Server Backuped and Stopped" --subject 'Server Minecraft est pret!' --region eu-west-1
else
    aws sns publish --topic-arn "$SNS_TOPIC_ARN" --message "Error on Server Backup" --subject 'Server Minecraft est pret!' --region eu-west-1
fi