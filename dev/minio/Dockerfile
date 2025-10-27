# 用官方 mc 镜像拿现成二进制，避免 apk/curl/外网
FROM --platform=$TARGETPLATFORM minio/mc:RELEASE.2025-08-13T08-35-41Z AS mcget

FROM --platform=$TARGETPLATFORM minio/minio:RELEASE.2025-09-07T16-13-09Z

# mc 在官方镜像里通常是 /usr/bin/mc
COPY --from=mcget /usr/bin/mc /usr/local/bin/mc

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
