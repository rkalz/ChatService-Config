echo "Stopping Cassandra"
docker stop cass-master cass-1 cass-2 2>&1 > /dev/null
docker rm cass-master cass-1 cass-2 2>&1 > /dev/null
echo "Stopped Cassandra"