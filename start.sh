docker network create -d bridge datacenter
cd cassandra && ./start.sh
cd ../redis && ./start.sh
cd ../../ChatService-Auth && ./start.sh 
cd ../ChatService-Frontend && ./start.sh 
cd ../ChatService-Sessions && ./start.sh
cd ../ChatService-Config/nginx && ./start.sh
