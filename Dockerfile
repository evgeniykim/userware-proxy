FROM nginx

#RUN apt-get update && apt-get install -y iputils-ping

COPY ./test-dev-default.conf /etc/nginx/conf.d/default.conf
