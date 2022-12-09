FROM docker

RUN apk add --update --no-cache apk-cron

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]