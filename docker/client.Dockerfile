FROM ubuntu:20.04 AS npm

ARG EVENT_HOST

USER root

RUN apt-get update && apt-get -y install \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -

RUN apt-get install nodejs -y \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 449 dockeruser && \
    useradd -r -m -u 449 -g dockeruser dockeruser

USER dockeruser

ENV EVENT_HOST=${EVENT_HOST}

RUN mkdir /home/dockeruser/project

WORKDIR /home/dockeruser/project

COPY package.json .

RUN npm install

COPY ./config ./config

COPY ./public ./public

COPY ./src ./src

RUN mkdir dist

RUN npm run build


FROM httpd:2.4.62 AS apache

COPY ./apache/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./apache/.htaccess /usr/local/apache2/htdocs/

COPY --from=npm /home/dockeruser/project/dist /usr/local/apache2/htdocs/

EXPOSE 3000
