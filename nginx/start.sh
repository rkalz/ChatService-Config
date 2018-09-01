echo "Starting internal load balancer"
docker run -d -p 8081:80 -it --name=ilb --network=datacenter nginx-ilb
echo "Started internal load balancer"