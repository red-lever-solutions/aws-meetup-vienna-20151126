FROM haproxy:1.6

MAINTAINER Johann Fuechsl <fuechsl@redlever.solutions>

ENV HAPROXY_USER haproxy

RUN groupadd --system ${HAPROXY_USER} && \
    useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER} && \
    chown -R ${HAPROXY_USER}:${HAPROXY_USER} /usr/local/etc/haproxy && \
    apt-get update && apt-get install -y unzip

ENV CONSUL_TEMPLATE_VERSION=0.11.1
ENV CONSUL_TEMPLATE_ARCHIVE=consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/${CONSUL_TEMPLATE_ARCHIVE} /
RUN unzip /${CONSUL_TEMPLATE_ARCHIVE} && \
    rm /${CONSUL_TEMPLATE_ARCHIVE} && \
    mv /consul-template /usr/local/bin/consul-template

COPY launch.sh /launch.sh
COPY config/ /consul-template/config.d
COPY template/ /consul-template/template.d

VOLUME /usr/local/etc/haproxy

CMD ["/launch.sh"]
