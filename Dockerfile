FROM node:12.16 as build-stage
RUN npm i -g @angular/cli@11.0.2
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app/
RUN ng build --prod --output-path=/app/dist


# Serve builded files
FROM nginxinc/nginx-unprivileged:stable-alpine

LABEL maintainer="paul.geser03@gmail.com"

# Change to non-root user
COPY --chown=101 --from=build-stage /app/dist/ /var/www
COPY --chown=101 nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
