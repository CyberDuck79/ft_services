#!/bin/bash
### COLORS
Red="\e[31m"
Green="\e[32m"
Yellow="\n\e[33;1m"
Light_yellow="\e[33m"
Default="\e[0m\n"
### SERVICES
services="ftps nginx mariadb wordpress phpmyadmin influxdb telegraf grafana"

minikube_install() {
    printf "${Yellow}🦆 - QUACK QUACK ! (Let's install minikube !)${Default}"
    sleep 1

    printf "${Light_yellow}🦆 - quack quack... (I install...)${Default}"
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    chmod +x minikube && sudo install minikube /usr/local/bin/ && rm minikube &&
    printf "${Green}Minikube installed${Default}" || { printf "${Red}Minikube installation failed${Default}" && exit 1; }
}

minikube_start() {
    printf "${Yellow}🦆 - QUACK QUACK ! (Let's start minikube !)${Default}"
    sleep 1

    printf "${Light_yellow}🦆 - quack quack... (I start minikube...)${Default}"
    minikube delete > /dev/null
    rm -rf ~/.minikube
    minikube start --driver=docker > /dev/null && \
    printf "${Green}Minikube started${Default}" || { printf "${Red}Minikube start failed${Default}" && exit 1; }
}

minikube_configure() {
    printf "${Yellow}🦆 - QUACK QUACK ! (Let's configure minikube !)${Default}"
    sleep 1

    printf "${Light_yellow}🦆 - quack quack... (I write configuration...)${Default}"
    kubectl create secret generic ssh-secret \
    --from-literal=ssh_user='flavien' --from-literal=ssh_pass='m@rt3@u' > /dev/null && \
    kubectl create secret generic ftps-secret \
    --from-literal=ftps_user='flavien' --from-literal=ftps_pass='m@rt3@u' > /dev/null && \
    kubectl create secret generic mariadb-secret \
    --from-literal=mysql_root_password='T0urn3v1s' > /dev/null && \
    kubectl create secret generic wordpress-secret \
    --from-literal=db_name='wordpress' --from-literal=db_user='flavien' \
    --from-literal=db_host='mariadb-svc' --from-literal=db_password='T0urn3v1s' > /dev/null && \
    kubectl create secret generic phpmyadmin-secret \
    --from-literal=pma_host='mariadb-svc' --from-literal=pma_port='3306' \
    --from-literal=pma_user='flavien' > /dev/null && \
    kubectl create secret generic influxdb-secret \
    --from-literal=influxdb_admin_user='flavien' --from-literal=influxdb_admin_password='T0urn3v1s' \
    --from-literal=influxdb_config_path='/etc/influxdb.conf' > /dev/null && \
    kubectl create secret generic telegraf-secret \
    --from-literal=influxdb_db='telegraf' --from-literal=influxdb_url='http://influxdb-svc:8086' > /dev/null && \
    printf "${Green}Configuration generated${Default}" || { printf "${Red}Configuration failed${Default}" && exit 1; }
    eval $(minikube docker-env)

    printf "${Light_yellow}🦆 - quack quack... (I activate addons...)${Default}"
    minikube addons enable metrics-server > /dev/null && \
    minikube addons enable dashboard > /dev/null && \
    minikube addons enable metallb > /dev/null && \
    printf "${Green}Addons activated${Default}" || { printf "${Red}addons activation failed${Default}" && exit 1; }
    SERVER_IP=$(minikube ip | grep -oE "\b([0-9]{1,3}\.){3}\b")
    sed -i.bak "s/IP/"$SERVER_IP"/g" config_map.yml
    sed -i.bak "s/http:\/\/IP/http:\/\/"$SERVER_IP"/g" services/nginx/index.html
    #sed -i.bak "s/http:\/\/IP/http:\/\/"$SERVER_IP"/g" services/mariadb/wordpress.sql
    sed -i.bak "s/address=IP/address="$SERVER_IP"/g" services/ftps/start.sh

}

setup_minikube() {
    minikube_install
    sudo usermod -aG docker $(whoami)
    minikube_start
    minikube_configure
}

#################################################

build_images() {
    printf "${Yellow}🦆 - QUACK QUACK ! (Let's buid the images !)${Default}"

    for service in $services
    do
        printf "${Light_yellow}🦆 - quack quack... (I build $service...)${Default}"
        docker build services/$service -t $service-img > /dev/null && \
        printf "${Green}${service} image builded${Default}" || { printf "${Red}${service} image building failed${Default}" && exit 1; }
    done
}

apply_configuration() {
    printf "${Yellow}🦆 - QUACK QUACK ! (Let's apply the configurations !)${Default}"

    printf "${Light_yellow}🦆 - quack quack... (I apply metallb configuration...)${Default}"
    kubectl apply -f config_map.yml > /dev/null && \
    printf "${Green}Load Balancer configuration applied${Default}" || { printf "${Red}Load Balancer configuration failed${Default}" && exit 1; }

    for service in $services
    do
        printf "${Light_yellow}🦆 - quack quack... (I apply $service configuration...)${Default}"
        kubectl apply -f services/${service}/deployment.yml > /dev/null && \
        printf "${Green}${service} deployment configuration applied${Default}" || { printf "${Red}${service} deployment failed${Default}" && exit 1; }
        kubectl apply -f services/${service}/service.yml > /dev/null && \
        printf "${Green}${service} service configuration applied${Default}" || { printf "${Red}${service} service failed${Default}" && exit 1; }
    done
    rm config_map.yml && mv config_map.yml.bak config_map.yml
    rm services/nginx/index.html && mv services/nginx/index.html.bak services/nginx/index.html
    #sed -i.bak "s/http:\/\/"$SERVER_IP"/http:\/\/IP/g" services/mariadb/wordpress.sql
    rm services/ftps/start.sh && mv services/ftps/start.sh.bak services/ftps/start.sh
}

#################################################

report() {
    printf "${Light_yellow}🦆 - quack quack... (Producing reports with my tiny wings...)${Default}"
    sleep 10
    printf "${Yellow}Load balancer${Default}"
    kubectl describe configmap config -n metallb-system
    printf "${Yellow}Pods${Default}"
    kubectl get pods
    printf "${Yellow}Services${Default}"
    kubectl get services
    minikube dashboard > /dev/null &
}

#################################################

clear
printf "${Yellow}🦆🦆🦆 FT_DUCKS 🦆🦆🦆${Default}"
setup_minikube
build_images
apply_configuration
printf "${Yellow}🦆🦆🦆 All the ducks are ready !!! 🦆🦆🦆${Default}"
report