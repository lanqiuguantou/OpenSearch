FROM alpine:3.20 AS mcget
RUN apk add --no-cache curl ca-certificates && \
    curl -L "https://dl.min.io/client/mc/release/linux-amd64/mc" -o /mc && \
    chmod +x /mc


FROM minio/minio:RELEASE.2025-09-07T16-13-09Z

COPY --from=mcget /mc /usr/local/bin/mc

ARG bucket
ARG accessKey
ARG secretKey

ENV MINIO_ROOT_USER=${accessKey}
ENV MINIO_ROOT_PASSWORD=${secretKey}
ENV MINIO_VOLUMES=/minio/data

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000 9001
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

