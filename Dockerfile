# Stage 1
FROM node:10-alpine as builder

COPY package.json package-lock.json ./
RUN npm install && mkdir /ng-app && mv ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .
RUN npm run ng build --prod --output-path=dist


# Stage 2
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
RUN sed -i.bak 's/listen\(.*\)80;/listen 4200;/' /etc/nginx/conf.d/default.conf
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
COPY --from=builder /ng-app/dist/openshift-angular-project /usr/share/nginx/html

RUN chmod -R 777 /var/run /var/log/nginx /var/cache/nginx
