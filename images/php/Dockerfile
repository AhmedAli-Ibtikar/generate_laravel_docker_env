FROM php:7.3-fpm

ARG PORT

RUN sed -i "s/9000/$PORT/" /usr/local/etc/php-fpm.d/zz-docker.conf

RUN apt-get update -y && apt-get install -y sendmail libpng-dev

RUN docker-php-ext-install mbstring tokenizer mysqli pdo_mysql bcmath sockets gd

ADD ./scripts/start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]