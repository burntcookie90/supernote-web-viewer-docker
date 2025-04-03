FROM node:21-alpine3.18 as build

RUN apk add --no-cache git
WORKDIR /app
RUN git clone --depth 1 https://github.com/burntcookie90/supernote-web-viewer.git repo
RUN cd repo && npm install && npm run build

FROM nginx:1.25.3-alpine
LABEL maintainer="Vishnu Rajeevan <docker@vishnu.email>"

WORKDIR /app
COPY --from=build /app/repo/dist /usr/share/nginx/html
