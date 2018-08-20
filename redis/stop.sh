echo "Stopping Redis cache"
docker stop redis-master 2>&1 > /dev/null
docker rm redis-master 2>&1 > /dev/null
echo "Stopped Redis cache"