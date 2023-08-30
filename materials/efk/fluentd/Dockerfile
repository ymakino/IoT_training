FROM fluent/fluentd:v1.14.6-1.1

USER root

RUN gem install elasticsearch -v 7.17.1
RUN gem install fluent-plugin-elasticsearch -v 5.2.0
RUN gem install fluent-plugin-mqtt-io
