var mysql = require('mysql');

//a pool of connections 
let pool = mysql.createPool({
    host: 'zoo.c1jmiaqoplkv.us-east-2.rds.amazonaws.com',
    user: 'admin',
    password: 'Ilovezoos2020',
    database: 'zoo_schema' 
});


//to verify if employee user and password are correct when logging. It returns true/false 
//if you need some help understanding https://www.mysqltutorial.org/mysql-nodejs/select/
authenticateEmployee = function(data, callback){

  // ? is a placeholder for the data passed into the authenticateEmployee function
  // The placeholder will be substituted by the values of the array in sequence
  var sql = "SELECT employee_id,pswd FROM zoo_schema.employee WHERE employee_id =?;"
  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    

    connection.query(sql, data, function(err, results) {
      connection.release();
      if(err) { console.log(err); callback(true); return; }
      if(!results[0]){
        callback(false, false); //email isnt in the db so returns false that login is not correct
      }
      else if(results[0].pswd == data[1]){  //check if the db password matches what was entered in login form
        callback(false, true);   //returns true that the password was correct
      }else{
        callback(false, false);  //returns false that password is incorrect
      }
    });

  });

}
module.exports.authenticateEmployee = authenticateEmployee;



//to verify if employee user and password are correct when logging. It returns true/false 
//if you need some help understanding https://www.mysqltutorial.org/mysql-nodejs/select/
authenticateCustomer = function(data, callback){

  // ? is a placeholder for the data passed into the authenticateEmployee function
  // The placeholder will be substituted by the values of the array in sequence
  var sql = "SELECT email,pswd FROM zoo_schema.customer WHERE email=?;"
  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    

    connection.query(sql, data, function(err, results) {
      connection.release();
      if(err) { console.log(err); callback(true); return; }
      if(!results[0]){
        callback(false, false); //email isnt in the db so returns false that login is not correct
      }
      else if(results[0].pswd == data[1]){  //check if the db password matches what was entered in login form
        callback(false, true);   //returns true that the password was correct
      }else{
        callback(false, false);  //returns false that password is incorrect
      }
    });

  });

}
module.exports.authenticateCustomer = authenticateCustomer;




//connects the sign up form to the database. It can handle errors but
// it doesnt tell the user what the error is
//if a user with the same email exists in the db it will not add the new user
signUpCustomer = function(data, callback){

  
  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    
    var sql1 = "SELECT email FROM zoo_schema.customer WHERE email LIKE ?;"
    var str = "%" + data[2] + "%";

    connection.query(sql1, str, function(err, results) {
      
      if(err) { console.log(err); callback(true); return; }

      //if there are results then another user exists with the same email so we should not add the user
      if(results){
        if(results[0].email === data[2]){
          connection.release();
          callback(false, false);  //there is a user with same email in the database
          
        }
      }else{
        
        // this command actually inserts the new user into the db only if there is no user with the same email existing
        var sql = "INSERT INTO zoo_schema.customer (f_name, l_name, email, pswd, date_registered, isMember, membership_expiration) VALUES (?,?,?,?, CURDATE(), 0, NULL);"
        connection.query(sql, data, function(err, results) {
          connection.release();
          if(err) { console.log(err); callback(true); return; }

          callback(false, true);  //no error return to routes.js
          
        });
      }
      
    });

  });

}
module.exports.signUpCustomer = signUpCustomer;
getProducts = function(callback){

  var sql = "SELECT * FROM product WHERE stock > 0 OR stock IS NULL ORDER BY gift_shop_id, product_id";
  var items=[];
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(res.length)
        callback(res);
    });
  });
}
module.exports.getProducts = getProducts;


makeOnlinePurchase = function(order, callback){
  var sql = "INSERT INTO `order` (order_id, product_id, product_size, quantity, email, address, city, state, zipcode, price_total, in_store, order_status) VALUES (null,";
  sql += order.product_id; sql += ",'"; sql+= order.product_size; sql += "',"; sql += order.quantity; sql += ",'"; sql += order.email; sql += "','"; sql += order.address; sql += "','"; sql += order.city; sql += "','"; sql += order.state; sql += "',"; sql += order.zipcode; sql += ","; sql += order.total;sql += ","; sql += "0"; sql += ","; sql += "'placed');";
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });
  });
}
module.exports.makeOnlinePurchase = makeOnlinePurchase;






//manager page functions
getAllEmployees = function(callback){
  var sql = "SELECT * FROM zoo_schema.employee;";

  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getAllEmployees= getAllEmployees;


getFoodStock = function(callback){
  var sql = "SELECT * FROM zoo_schema.food_supply;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}

module.exports.getFoodStock= getFoodStock;

getMedicineStock = function(callback){
  var sql = "SELECT * FROM zoo_schema.medicine_supply;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getMedicineStock= getMedicineStock;

//get the price_totals from orders table
getMonthlyRevenue = function(callback){
  var sql = "SELECT SUM(price_total) monthlyRevenue FROM zoo_schema.order WHERE order_date BETWEEN (CURRENT_DATE() - INTERVAL 1 MONTH) AND CURRENT_DATE();";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getMonthlyRevenue= getMonthlyRevenue;


getWeeklyRevenue = function(callback){
  var sql = "SELECT SUM(price_total) weeklyRevenue FROM zoo_schema.order WHERE order_date BETWEEN (CURRENT_DATE() - INTERVAL 1 MONTH) AND CURRENT_DATE();";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getWeeklyRevenue= getWeeklyRevenue;


getDailyRevenue = function(callback){
  var sql = "SELECT SUM(price_total) AS dailyRevenue FROM zoo_schema.order WHERE date(order_date)  = date(now());";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getDailyRevenue= getDailyRevenue;

getCumulativeRevenue = function(callback){
  var sql = "SELECT SUM(price_total) AS cumulativeRevenue FROM zoo_schema.order;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getCumulativeRevenue= getCumulativeRevenue;


//returns each product and its frequency sold from the orders table.
getMostSoldProducts = function(callback){
  var sql = "SELECT product_id, COUNT(product_id) AS MOST_FREQUENT FROM zoo_schema.order GROUP BY product_id ORDER BY COUNT(product_id) DESC";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
      else
        callback(res);
    });

  });
}
module.exports.getMostSoldProducts = getMostSoldProducts;


