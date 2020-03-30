var mysql = require('mysql');

//a pool of connections 
let pool = mysql.createPool({
    host: 'zoo.c1jmiaqoplkv.us-east-2.rds.amazonaws.com',
    user: 'admin',
    password: 'Ilovezoos2020',
    database: 'zoo_schema' 
});


//test a connection. Successful connection displays Connected to the MySQL server
// in the console
pool.getConnection(function(err, connection) {
  if (err) {
    return console.error('error: ' + err.message);
  }
 
  console.log('Connected to the MySQL server.');

  connection.release();
});


//returns the names of all tables in database
//includes alot of system tables as well
testConnection = function(data, callback){
  var sql = "SELECT table_name FROM information_schema.tables;"
  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    

    connection.query(sql, data, function(err, results) {
      connection.release();
      if(err) { console.log(err); callback(true); return; }
      callback(false, results);
    });

  });

}
module.exports.testConnection = testConnection;