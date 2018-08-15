docker run -d -p 7000:7000 -p 7001:7001 -p 7199:7199 \
    -p 9042:9042 -p 9142:9142 -p 9160:9160 --name=cass cassandra

var=$(cqlsh <<< "quit" 2>&1 > /dev/null)
while [[ "${#var}" -ne 0 ]]; do
    sleep 1;
    var=$(cqlsh <<< "quit" 2>&1 > /dev/null);
done

cqlsh -f accounts.cql
cqlsh -f sessions.cql