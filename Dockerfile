FROM docker

RUN apk add --update --no-cache apk-cron tzdata

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]