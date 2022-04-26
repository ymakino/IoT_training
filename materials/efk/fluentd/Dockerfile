FROM fluent/fluentd:v1.14.6-1.1

USER root

RUN fluent-gem  install elasticsearch -v 7.17.1
RUN fluent-gem  install fluent-plugin-elasticsearch
RUN gem install fluent-plugin-mqtt-io
