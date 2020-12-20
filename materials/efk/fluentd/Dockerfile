FROM fluent/fluentd:v1.6-debian-1

USER root

RUN apt update && apt install -y gcc make ruby-dev

RUN fluent-gem  install fluent-plugin-elasticsearch
RUN gem install fluent-plugin-mqtt-io
