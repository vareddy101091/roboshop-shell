script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[34m>>>>>>>>> Install GoLang <<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[34m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>> Create App Dir <<<<<<<<\e[0m"
mkdir /app

echo -e "\e[34m>>>>>>>>> Download App Content <<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[34m>>>>>>>>> Unzip App Content <<<<<<<<\e[0m"

unzip /tmp/dispatch.zip

echo -e "\e[34m>>>>>>>>> Download the dependencies & build the software. <<<<<<<<\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[34m>>>>>>>>> Setup SystemD Payment Service <<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[34m>>>>>>>>> Start Dispatch Service <<<<<<<<\e[0m"

systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
