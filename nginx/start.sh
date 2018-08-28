echo "Starting internal load balancer"
docker run -d -it --name=ilb nginx-ilb
echo "Started internal load balancer"