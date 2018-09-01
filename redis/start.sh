echo "Starting Redis cache"
docker run -d --network=datacenter -p 127.0.0.1:6379:6379 --name=redis-master redis:4.0-alpine
echo "Started Redis cache"