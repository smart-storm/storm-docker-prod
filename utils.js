//this file stands here until storm-api will have single login database file

var jwt = require('jsonwebtoken');
var MongoClient = require('mongodb').MongoClient;

var url = "mongodb://mongo:27017/storm-db";
var secret='SUPER_SECRET';

var cassandra = require('cassandra-driver');
var async = require('async');

var cassandraClient =  new cassandra.Client({contactPoints: ['cassandra'], keyspace: 'smartstorm'
//     protocolOptions: {
//     port: 9043 //only for testing
// }
});

getSecret=function(req,payload,done){
    if(done)
        done(null,secret);
    else
        return secret;
};

getToken=function (req) {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        return req.headers.authorization.split(' ')[1];
    } else if (req.query && req.query.token) {
        return req.query.token;
    }
    return null;
};

getUserFromToken=function(req, token){
    var token = token || getToken(req);
    try {
        return jwt.verify(token,getSecret({},{}));
    } catch(err){
        // console.log(err);
        return false;
    }
};

getDbConnection=function(){
    return MongoClient.connect(url);
};

getCassandraConnection=function () {
    return cassandraClient;
};

generateToken=function(user){
    return jwt.sign({
        sub: user.email,
        id: user._id,
    }, secret, {
        expiresIn:  3*60*60
    });
};

module.exports={
    getToken:getToken,
    getSecret:getSecret,
    getDbConnection:getDbConnection,
    getCassandraConnection:getCassandraConnection,
    generateToken:generateToken,
    getUserFromToken:getUserFromToken
}