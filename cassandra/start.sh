MULTI_NODES=0
if [ "$#" == 1 ]; then
    MULTI_NODES="$1"
else
    echo "Starting with single node"
fi

echo "Starting Cassandra master server"
docker run -d -p 127.0.0.1:7000:7000 -p 127.0.0.1:7001:7001 -p 127.0.0.1:7199:7199 \
    -p 127.0.0.1:9042:9042 -p 127.0.0.1:9142:9142 -p 127.0.0.1:9160:9160 \
    -e CASSANDRA_BROADCAST_ADDRESS:127.0.0.1 \
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
    docker run -d -p 127.0.0.2:7000:7000 -p 127.0.0.2:7001:7001 -p 127.0.0.2:7199:7199 \
        -p 127.0.0.2:9042:9042 -p 127.0.0.2:9142:9142 -p 127.0.0.2:9160:9160 \
        -e CASSANDRA_BROADCAST_ADDRESS:127.0.0.2 \
        -e CASSANDRA_SEEDS:127.0.0.1 \
        --name=cass-1 cassandra:3.11

    echo "Creating node 3"
    docker run -d -p 127.0.0.3:7000:7000 -p 127.0.0.3:7001:7001 -p 127.0.0.3:7199:7199 \
        -p 127.0.0.3:9042:9042 -p 127.0.0.3:9142:9142 -p 127.0.0.3:9160:9160 \
        -e CASSANDRA_BROADCAST_ADDRESS:127.0.0.3 \
        -e CASSANDRA_SEEDS:127.0.0.1 \
        --name=cass-2 cassandra:3.11
fi

echo "Cassandra cluster online"