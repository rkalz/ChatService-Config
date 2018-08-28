echo "Stopping internal load balamcer"
docker stop ilb >/dev/null
docker rm ilb >/dev/null
echo "Stopped internal load balancer"