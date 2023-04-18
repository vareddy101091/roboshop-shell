script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[32m>>>>>>>>> Install nginx <<<<<<<<\e[0m"
yum install nginx -y

echo -e "\e[32m>>>>>>>>> Create Nginx Reverse Proxy Configuration. <<<<<<<<\e[0m"
cp ${script_path}roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m>>>>>>>>> Remove Default Content Nginx is serving <<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m>>>>>>>>> Download the frontend content <<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m>>>>>>>>> Extract the frontend content. <<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[32m>>>>>>>>>Start & Enable Nginx service  <<<<<<<<\e[0m"
systemctl restart nginx
systemctl enable nginx


