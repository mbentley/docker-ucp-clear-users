FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apk -U add bash curl jq

COPY clear_users.sh /clear_users.sh

CMD ["/clear_users.sh"]
