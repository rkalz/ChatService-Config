echo "Starting internal load balancer"
docker run -d -it -p 8081:80 --name=ilb nginx-ilb
echo "Started internal load balancer"