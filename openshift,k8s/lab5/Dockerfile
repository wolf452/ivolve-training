FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY ./static_website/ .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

