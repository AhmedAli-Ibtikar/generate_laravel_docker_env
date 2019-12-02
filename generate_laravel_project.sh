#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied, Please provide project name"
fi

root=/var/dev/$1

resources_dir=/var/dev/generate_laravel_project

# making project root
mkdir $root

cp -R $resources_dir/stub/docker-stub/* $root

cd $root/app

curl -sS http://cabinet.laravel.com/latest.zip > laravel.zip
unzip laravel.zip
rm -rf laravel.zip

echo $root/app

docker run -it --rm -u 1000 -v $root/app:/app -w /app composer:1.8.6 /bin/bash -c "composer self-update && composer global require hirak/prestissimo && composer install"

sudo chown -R ahmed:ahmed $root/app/vendor

cp $root/app/.env.example $root/app/.env
