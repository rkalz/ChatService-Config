echo "Stopping internal load balamcer"
docker stop ilb >/dev/null
docker rm auth >/dev/null
echo "Stopped internal load balancer"