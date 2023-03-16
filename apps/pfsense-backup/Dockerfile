FROM ubuntu:16.04

ARG BUILD_DATE
ARG VERSION
LABEL build_date="${BUILD_DATE}"
LABEL version="${VERSION}"

ENV PFSENSE_USER none
ENV PFSENSE_PASS none
ENV PFSENSE_IP 192.168.1.1

ENV APTLIST="ca-certificates cron wget"

COPY backup.sh /backup.sh
COPY startup.sh /startup.sh

RUN apt-get update && apt-get install -y --no-install-recommends $APTLIST && apt-get clean && chmod 755 /backup.sh /startup.sh

VOLUME ["/data"]

CMD ["/startup.sh"]
