cd cassandra && ./start.sh 1
cd ../redis && ./start.sh 
cd ../../ChatService-Auth && ./start.sh 
cd ../ChatService-Frontend && ./start.sh 
cd ../ChatService-Sessions && ./start.sh
