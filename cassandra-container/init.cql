CREATE KEYSPACE IF NOT EXISTS smartstorm WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };

CREATE TABLE IF NOT EXISTS smartstorm.sensors (
   sensorid text,
   userid text,
   created_epoch int,
   created text,
   sensordesc text,
   value text,
   PRIMARY KEY ((sensorid, userid), created_epoch)
) WITH CLUSTERING ORDER BY (created_epoch DESC);
