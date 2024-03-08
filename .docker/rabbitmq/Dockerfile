FROM rabbitmq:3.13.0-management

ENV RABBITMQ_ERLANG_COOKIE "secret"

COPY .docker/rabbitmq/docker-entrypoint.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]