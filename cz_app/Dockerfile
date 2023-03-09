FROM ubuntu:22.04 AS builder

# Prerequisites
RUN apt update
RUN apt install -y \
            curl \
            git \
            unzip \
            xz-utils \
            libglu1-mesa \
            openjdk-8-jdk

# Install flutter
RUN curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.6-stable.tar.xz
RUN tar -xf flutter_linux_3.7.6-stable.tar.xz -C /usr/share/
RUN rm flutter_linux_3.7.6-stable.tar.xz
ENV PATH "$PATH:/usr/share/flutter/bin"

# Prevent dubious ownership warning from git
RUN git config --global --add safe.directory /usr/share/flutter

# Check status of flutter installation
RUN flutter doctor

WORKDIR /opt/MY_AWESOME_NAMER

COPY . .

RUN flutter pub get
RUN flutter build web

# Run web server from nginx
FROM nginx:1.23 as runtime

COPY --from=builder /opt/MY_AWESOME_NAMER/build /usr/share/nginx/html

EXPOSE 3000