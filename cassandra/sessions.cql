CREATE KEYSPACE sessions
    WITH REPLICATION = {
        'class':'SimpleStrategy',
        'replication_factor': 3
    };

CREATE TABLE sessions.sessions (
    userid uuid,
    origin text,
    active boolean,
    sessionid text,
    ts timestamp,
    PRIMARY KEY (userid, origin)
) WITH CLUSTERING ORDER BY (origin ASC);
