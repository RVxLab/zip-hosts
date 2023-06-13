#!/usr/bin/env bash

set -euo pipefail

DOMAINS_SOURCE="https://raw.githubusercontent.com/trickest/zip/main/zip-domains.txt"
DOMAINS_SOURCE_FILE="./domains.txt"
DEST_FILE="./zip.hosts"

/usr/bin/curl -sL -o "$DOMAINS_SOURCE_FILE" "$DOMAINS_SOURCE"

HEADER=$(cat << END
# This hosts file contains all zip domains as reported by the trickest/zip repo on GitHub
# 
# Source: $DOMAINS_SOURCE
# Date: $(LC_TIME=C.UTF-8 date -u)
# Number of domains: $(wc -l < "$DOMAINS_SOURCE_FILE")
# =============================================
END
)

echo "$HEADER" > "$DEST_FILE"

while IFS= read -r DOMAIN
do
    echo "0.0.0.0 $DOMAIN" >> "$DEST_FILE"
done < "$DOMAINS_SOURCE_FILE"

