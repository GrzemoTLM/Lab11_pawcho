#!/bin/bash

cd /home/grzegorz/Documents/Studia/Docker/11/lab11

echo "=== Uruchamianie wszystkich kontenerów nginx ==="

if ! docker network ls | grep -q lab11net; then
    echo "Tworzenie sieci lab11net..."
    docker network create lab11net
fi

echo "Usuwanie istniejących kontenerów (jeśli istnieją)..."
docker rm -f web1 web2 web3 2>/dev/null || true

echo "Uruchamianie kontenera web1..."
docker run -d \
  --name web1 \
  --network lab11net \
  -p 8081:80 \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/html,target=/usr/share/nginx/html,readonly \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/web1-logs,target=/var/log/nginx \
  nginx:latest

echo "Uruchamianie kontenera web2..."
docker run -d \
  --name web2 \
  --network lab11net \
  -p 8082:80 \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/html,target=/usr/share/nginx/html,readonly \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/web2-logs,target=/var/log/nginx \
  nginx:latest

echo "Uruchamianie kontenera web3..."
docker run -d \
  --name web3 \
  --network lab11net \
  -p 8083:80 \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/html,target=/usr/share/nginx/html,readonly \
  --mount type=bind,source=/home/grzegorz/Documents/Studia/Docker/11/lab11/web3-logs,target=/var/log/nginx \
  nginx:latest

echo "=== Wszystkie kontenery uruchomione ==="
echo "Sprawdzanie statusu:"
docker ps | grep -E "(web1|web2|web3)"

echo ""
echo "Dostępne adresy:"
echo "- web1: http://localhost:8081"
echo "- web2: http://localhost:8082"
echo "- web3: http://localhost:8083"

echo ""
echo "Aby zatrzymać wszystkie kontenery, użyj: docker stop web1 web2 web3"
echo "Aby usunąć wszystkie kontenery, użyj: docker rm web1 web2 web3"
