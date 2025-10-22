#!/usr/bin/env bash
set -euo pipefail

ES="http://127.0.0.1:9200"
REPO="s3-remote"
BUCKET="os-remote-bucket"

echo "[1/3] register s3 repo: ${REPO}"
curl -fsS -XPUT "${ES}/_snapshot/${REPO}" -H 'Content-Type: application/json' -d "{
  \"type\": \"s3\",
  \"settings\": {
    \"bucket\": \"${BUCKET}\",
    \"base_path\": \"dev\",
    \"path_style_access\": true
  }
}" || true

echo "[2/3] ensure cluster settings"
curl -fsS -XPUT "${ES}/_cluster/settings" -H 'Content-Type: application/json' -d '{
  "persistent": {
    "cluster.remote_store.state.enabled": true,
    "cluster.routing.search_replica.strict": true
  }
}'

echo "[3/3] create index with search replicas + remote store"
curl -fsS -XPUT "${ES}/my-index" -H 'Content-Type: application/json' -d "{
  \"settings\": {
    \"index\": {
      \"number_of_shards\": 1,
      \"number_of_replicas\": 1,
      \"number_of_search_replicas\": 2,
      \"remote_store.segment.repository\":  \"${REPO}\",
      \"remote_store.translog.repository\": \"${REPO}\",
      \"remote_store.state.repository\":    \"${REPO}\"
    }
  }
}" || true

echo "Done."

