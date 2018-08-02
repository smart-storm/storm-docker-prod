var mongoConnectionString = "mongodb://mongo:27017/storm-db";
var jwtSecret = "SUPER_SUPER_SECRET";
var cassandraContactPoint = "cassandra";
var cassandraKeyspace = "smartstorm";
var kafkaHost = "kafka:9092";

module.exports = {
    mongoConnectionString,
    cassandraContactPoint,
    cassandraKeyspace,
    jwtSecret,
    kafkaHost
};
