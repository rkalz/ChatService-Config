MULTI_NODES=0
if [ "$#" == 1 ]; then
    MULTI_NODES="$1"
else
    echo "Starting with single node"
fi

echo "Starting Cassandra master server"
docker run -d -p 7199:7199 -p 9042:9042 -e CASSANDRA_BROADCAST_ADDRESS:cass-master \
    --name=cass-master cassandra:3.11

echo "Connecting to Cassandra master server"
err=$(cqlsh <<< "quit" 2>&1 > /dev/null)
while [[ "${#err}" -ne 0 ]]; do
    sleep 1;
    err=$(cqlsh <<< "quit" 2>&1 > /dev/null);
done

echo "Creating tables"
cqlsh -f accounts.cql
cqlsh -f sessions.cql

if [ $MULTI_NODES = 1 ]; then
    echo "Creating node 2"
    docker run -d \
        -e CASSANDRA_BROADCAST_ADDRESS:cass-1 \
        -e CASSANDRA_SEEDS:cass-master \
        --name=cass-1 cassandra:3.11

    echo "Creating node 3"
    docker run -d \
        -e CASSANDRA_BROADCAST_ADDRESS:cass-2 \
        -e CASSANDRA_SEEDS:cass-master \
        --name=cass-2 cassandra:3.11
fi

echo "Cassandra cluster online"