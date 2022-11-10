FROM nginx:1.17.4

RUN apt-get update && apt-get install nano

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
