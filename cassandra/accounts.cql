CREATE KEYSPACE accounts
    WITH REPLICATION = {
        'class':'SimpleStrategy',
        'replication_factor': 3
    };

CREATE TABLE accounts.users (
    username text PRIMARY KEY,
    hash text,
    userid uuid
);