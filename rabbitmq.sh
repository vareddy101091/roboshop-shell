script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[35m>>>>>>>>> Setup ErLang Repos <<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[35m>>>>>>>>> Setup RabbitMQ Repos <<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[35m>>>>>>>>> Install ErLang & RabbitMQ <<<<<<<<\e[0m"
yum install erlang rabbitmq-server -y

echo -e "\e[35m>>>>>>>>> Start RabbitMQ Service <<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "\e[35m>>>>>>>>> Add Application User in RabbtiMQ <<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
