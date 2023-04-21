app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {
  echo -e "\e[31m>>>>>>>>> $1 <<<<<<<<\e[0m"
  }

func_nodejs() {
  print_head "Configuring NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print_head "Install NodeJS"
  yum install nodejs -y

  print_head "Add Application User"
  useradd ${app_user}

  print_head "Create Application Directory"
  rm -rf /app
  mkdir /app

  print_head "Download App Content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app

  print_head "Unzip App Content"
  unzip /tmp/${component}.zip

  print_head "Install NodeJS Dependencies"
  npm install

  print_head "Create Application Directory"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  print_head "Start Cart Service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}
}
