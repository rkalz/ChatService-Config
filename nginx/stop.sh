echo "Stopping internal load balancer"
docker stop ilb >/dev/null
docker rm ilb >/dev/null
echo "Stopped internal load balancer"