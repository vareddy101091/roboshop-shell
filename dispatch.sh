script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



func_print_head "Install GoLang"
yum install golang -y &>>$log_file
func_stat_check $?

func_print_head "Add Application User"
useradd ${app_user} &>>$log_file
func_stat_check $?

func_print_head "Create App Dir"
mkdir /app &>>$log_file
func_stat_check $?

func_print_head "Download App Content"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>$log_file
cd /app
func_stat_check $?


func_print_head "Unzip App Content"
unzip /tmp/dispatch.zip &>>$log_file
func_stat_check $?

func_print_head "Download the dependencies & build the software."
cd /app
go mod init dispatch &>>$log_file
go get &>>$log_file
go build &>>$log_file
func_stat_check $?

func_print_head "Setup SystemD Payment Service"
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
func_stat_check $?

func_print_head "Start Dispatch Service"

systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl start dispatch &>>$log_file
func_stat_check $?