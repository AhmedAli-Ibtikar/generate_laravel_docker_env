#!/usr/bin/env bash

getParameters() {
    printf "Path to the folder \n"

    read path

    printf "\nGive me the folder name \n"

    read folder_name
}

# Check if path exist
checkPathExist() {
    echo "$1"
    if [ ! -d "$1" ]
    then
        printf "Directory %s doesn't exist. \n" "$1"
        exit
    fi
}

# Add end backslash
addEndBackSlash()
{
    STR="$1"

    length=${#STR}
    last_char=${STR:length-1:1}

    [[ $last_char != "/" ]] && STR="$STR/"; :

    echo $STR
}

printf "Welcome \n"

getParameters
checkPathExist $path

path=$(addEndBackSlash $path)

root=$path$folder_name

resources_dir=/var/dev/Projects/generate_laravel_project

# making project root
mkdir $root

cp -R $resources_dir/stub/docker-stub/* $root

cd $root/app

curl -sS http://cabinet.laravel.com/latest.zip > laravel.zip
unzip laravel.zip
rm -rf laravel.zip

echo $root/app

docker run -it --rm -v $root/app:/app -w /app composer:1.8.6 /bin/bash -c "composer self-update && composer global require hirak/prestissimo && composer install"

sudo chown -R ahmed:ahmed $root/app/vendor

cp $root/app/.env.example $root/app/.env

chown -R 1000:1000 $root/app/storage
