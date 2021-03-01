#!/bin/sh

#Scrip Install Pachs (Apache - php - Mysql - phpmyadmin)
#versions: Apache 2.4 - PHP 7.4 - Mysql (Maria DB)
#Operacions Systems (Debian, Ubunto, Mint, Centos, RedHat)


MEUSO=`hostnamectl | grep System` # Declaraçao da Variável que será usada no código.
export MEUSO


function install_pach_debian { #Declaração da função de instalação dos pacotes.
	echo "------------------------------------------------------------------\n" 
    echo "       Instalando e Configurando Servidor Apache.....\n"
    echo "------------------------------------------------------------------\n" 

    apt install apache2 -y && systemctl enable apache2 && systemctl start apache2 #Instala apache, habilita serviço na instalação e Inicia o serviço.

    echo "Servidor Apache Instalado.\n"
    echo "\n"	
    echo "\n"
    echo "------------------------------------------------------------------\n"
    echo "             Instalando e Configurando PHP 7.3"
    echo "------------------------------------------------------------------\n"
    echo "\n"
    echo "\n"

    apt -y install php php-common libapache2-mod-php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath 
    #Instala PHP e as principais extensões
    echo "Pacotes PHP Instalados.\n"
    systemctl restart apache2 #Restarta o Serviço do Apache.

    echo "------------------------------------------------------------------\n"
    echo "             Instalando e Configurando o MariaDB                  \n"
    echo "------------------------------------------------------------------\n"
    echo "\n"
    echo "\n"

    apt -y apt install mariadb-server; mysql_secure_installation
    systemctl start mariadb
    systemctl enable mariadb
    #Instala PHP e as principais extensões
    echo "Pacotes MariaDB Instalados.\n"

    echo "------------------------------------------------------------------\n"
    echo "         Instalando e Configurando o phpMyadmin....               \n"
    echo "------------------------------------------------------------------\n"
    echo "\n"
    echo "\n"

    apt install wget
    wget -P Downloads https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip
    mv Downloads/phpMyAdmin-/ /usr/share/phpmyadmin
    mkdir -p /var/lib/phpmyadmin/tmp
    chown -R www-data:www-data /var/lib/phpmyadmin
    mkdir /etc/phpmyadmin/
    

    phpenmod php-mbstring
    systemctl restart apache2
    echo "Pacote phpMyadmin Instalado.\n"

    echo "------------------------------------------------------------------\n"
    echo "             Servidor LAMP Instalado e Confogurado                \n"
    echo "------------------------------------------------------------------\n"

}


if echo $MEUSO | grep -q -i Debian
        then
        echo "---------------------------------------\n"
        echo "[     "$MEUSO".]\n"
        echo "---------------------------------------\n"        

        echo "[verificando lista de repositórios padrões do sistema operacional ....]\n"

        if grep -i -q "main" /etc/apt/sources.list; then 
                echo "[Repositórios Atualizados]\n"

                echo "[Atualizando o Sistema Operacional e Lista de programas.....]\n"
                
                apt update -y; apt upgrade -y
                
                echo "\nSistema atualizado, tudo Pronto para instalação dos pacotes.\n"

                install_pach_debian
        else
                echo "[Atualizando lista dos repositórios....]\n"

                printf "deb http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list
                printf "#deb-src http://deb.debian.org/debian buster main contrib non-free\n" >> /etc/apt/sources.list

                printf "deb http://deb.debian.org/debian-security/ buster / updates main contrib non-free" >> /etc/apt/sources.list
                printf "#deb-src http://deb.debian.org/debian-security/ buster / updates main contrib non-free\n" >> /etc/apt/sources.list
				
				printf "deb http://deb.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list
                printf "#deb-src http://deb.debian.org/debian buster-updates main contrib non-free\n" >> /etc/apt/sources.list

                echo "[Atualizando o Sistema Operacional e Lista de programas....]\n"
                apt update -y; apt upgrade -y
                echo "\nSistema atualizado, tudo Pronto para instalação dos pacotes.\n"
                install_pach_debian
        fi

elif echo $MEUSO | grep Ubuntu
                then echo "é o seu sistema Operacional."
elif echo $MEUSO | grep RedHat
                then echo "é o seu sistema Operacional."

elif echo $MEUSO | grep Ubuntu
                then echo "é o seu sistema Operacional."

elif echo $MEUSO | grep Mint
                then echo "é o seu sistema Operacional."
elif echo $MEUSO | grep Fedora
                then echo "é o seu sistema Operacional."
else
        echo "O programa não atende a esse Sistema Operaciona"
        echo ""
        echo " Altere o código fonte do programa ou entre em contato com o autor: teclucasteixeira@gmail.com"

fi
