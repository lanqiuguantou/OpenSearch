#!/usr/bin/env bash
set -euo pipefail

: "${MINIO_ROOT_USER:?Missing MINIO_ROOT_USER}"
: "${MINIO_ROOT_PASSWORD:?Missing MINIO_ROOT_PASSWORD}"
: "${MINIO_VOLUMES:=/minio/data}"
: "${MINIO_CONSOLE_ADDRESS:=:9001}"
: "${MINIO_ADDRESS:=:9000}"

# 关键修复：调用 'minio'，不要写 '/minio'
exec minio server --console-address "${MINIO_CONSOLE_ADDRESS}" --address "${MINIO_ADDRESS}" "${MINIO_VOLUMES}"

