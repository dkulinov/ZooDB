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
      if(results[0]){
        if(results[0].email === data[2]){
          connection.release();
          callback(false, false);  //there is a user with same email in the database
          
        }
      }else{
        
        // this command actually inserts the new user into the db only if there is no user with the same email existing
        var sql = "INSERT INTO zoo_schema.customer (f_name, l_name, email, pswd, date_registered, isMember, memberUntil) VALUES (?,?,?,?, CURDATE(), 0, NULL);"
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

  var sql = "SELECT * FROM product WHERE product_id != 37378708 AND (stock > 0 OR stock IS NULL) ORDER BY gift_shop_id, product_id";
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


ringUpCustomer = function(order, callback)
{
  var sql = "INSERT INTO `order` (order_id, product_id, product_size, quantity, price_total, in_store, order_status) VALUES (null,";
  sql += order.product_id; sql += ",'"; sql+= order.product_size; sql += "',"; sql += order.quantity; sql += ","; sql += order.total;sql += ","; sql += "1"; sql += ","; sql += "'NA');";
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
module.exports.ringUpCustomer = ringUpCustomer;


getEmployeeName = function(employee,callback){

  var sql = "SELECT first_name, last_name FROM zoo_schema.employee WHERE employee_id = ";
  sql += employee.username;
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
        callback(res);
    });
  });
}
module.exports.getEmployeeName = getEmployeeName;



getEmployeeInfo = function(emp, callback, cb)
{
  var sql = "SELECT employee.department_id FROM employee WHERE employee.employee_id = ";
  sql += emp.username;
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res1){
      connection.release();
      if(err) console.log(err);
      else
      {
        pool.getConnection(function(err, connection){
          if(err) { console.log(err); callback(true); return; }
        var sql2 = "SELECT COUNT(*) AS isMgr FROM department WHERE manager_id = ";
        sql2 += emp.username;
        connection.query(sql2, function(err, res2)
        {
          connection.release();
          if(err) console.log(err);
          else
          {
            pool.getConnection(function(err, connection){
              if(err) { console.log(err); callback(true); return; }
            var sql3 = "SELECT COUNT(*) AS isCT FROM takes_care_of WHERE caretaker_id = ";
            sql3 += emp.username;
            connection.query(sql3, function(err, res3)
            {
              connection.release();
              if(err) console.log(err);
              else
              {
                callback(emp, res1[0].department_id, res2[0].isMgr, res3[0].isCT, false, cb);
              }
            })
          });
          }
        });
      });
      }
    });
  });
}
module.exports.getEmployeeInfo = getEmployeeInfo;


//List of all the animals that are in care of a certain employee
getEmployeesAnimals = function(employee,callback){

  var sql = "SELECT * FROM zoo_schema.animal NATURAL JOIN zoo_schema.takes_care_of WHERE caretaker_id = ";
  sql += employee.username, sql+= ";";
  var animals = [];
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, function(err, res){
      if(err) console.log(err);
        callback(res);
    });
  });
}
module.exports.getEmployeesAnimals = getEmployeesAnimals;


/* ------------------------------------- Manager Page functions ----------------------------------------- */

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


getAllVets = function(callback){
  var sql = "SELECT * FROM zoo_schema.employee WHERE department_id=9;"
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
module.exports.getAllVets= getAllVets;


getAllAnimals = function(callback){
  var sql = "SELECT * FROM zoo_schema.animal;";

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
module.exports.getAllAnimals= getAllAnimals;


getCareTakersInfo = function(callback){
  var sql = "SELECT * FROM zoo_schema.takes_care_of NATURAL JOIN zoo_schema.animal;"
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
module.exports.getCareTakersInfo= getCareTakersInfo;


//insert into zoo_schema.animal values (LPAD(FLOOR(RAND() * 999999.99), 7, '0'), 'Kai', 'Lion', current_date(), '2016-05-02', 'M', '111113', 'healthy', NULL, 2, 'lion.jpg');
insertNewAnimal = function(data, callback){

  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    
    var sql = "INSERT INTO zoo_schema.animal values (LPAD(FLOOR(RAND() * 999999.99), 8, '0'), ?, ?, current_date(), ?, ?, ?, ?, NULL, ?, ?);";


    connection.query(sql, data, function(err, results) {
        connection.release();
        if(err) { console.log(err); callback(true); return; }

        callback(false, true);  //no error return to app.js       

           
    });
  });
}
module.exports.insertNewAnimal= insertNewAnimal;


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


//function that can get the revenue from a date window
getRevenueTest = function(data, callback){

  var sql = "SELECT SUM(price_total) revenue FROM zoo_schema.order WHERE order_date BETWEEN ? AND ?;"
  pool.getConnection(function(err, connection) {
    if(err) { console.log(err); callback(true); return; }
    

    connection.query(sql, data, function(err, results) {
      connection.release();
      if(err) { console.log(err); callback(true); return; }
      else{ callback(false, results); }
    });

  });

}
module.exports.getRevenueTest = getRevenueTest;


getOrdersTest = function(data, callback){
  var sql = "SELECT * FROM zoo_schema.order WHERE order_date BETWEEN ? AND ?;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, data, function(err, res){
      if(err) console.log(err);
      else
        callback(false, res);
    });

  });
}
module.exports.getOrdersTest = getOrdersTest;


//returns each product and its frequency sold from the orders table from a date window

getMostSoldProductsTest = function(data, callback){
  var sql = "SELECT zoo_schema.order.product_id, zoo_schema.product.product_name, COUNT(zoo_schema.order.product_id) AS quantity FROM zoo_schema.order JOIN zoo_schema.product ON zoo_schema.order.product_id = zoo_schema.product.product_id WHERE order_date BETWEEN ? AND ? GROUP BY product_id ORDER BY COUNT(product_id) DESC;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, data, function(err, res){
      if(err) console.log(err);
      else
        callback(false,res);
    });

  });
}
module.exports.getMostSoldProductsTest = getMostSoldProductsTest;


//

getTicketDistribution = function(data, callback){
  var sql = "SELECT zoo_schema.order.product_id, zoo_schema.product.product_name, COUNT(zoo_schema.order.product_id) AS quantity FROM zoo_schema.order JOIN zoo_schema.product ON zoo_schema.order.product_id = zoo_schema.product.product_id WHERE order_date BETWEEN ? AND ? AND order.product_id <= 1000006 GROUP BY product_id ORDER BY COUNT(product_id) DESC;";
  
  pool.getConnection(function(err, connection){
    connection.release();
    if(err) { console.log(err); callback(true); return; }
  
    connection.query(sql, data, function(err, res){
      if(err) console.log(err);
      else
        callback(false,res);
    });

  });
}
module.exports.getTicketDistribution = getTicketDistribution;

/* ------------------------ ALERT FUNCTIONS ----------------------------------*/

getCareTakerAlerts = function(employee, time, callback)
{
  var sql = "SELECT caretaker_alerts.animal_id AS animalID, animal.animal_name AS animalName, animal.species AS species, caretaker_alerts.new_health_status AS health, DATE_FORMAT(caretaker_alerts.date_generated, '%Y-%m-%d') AS `date`  FROM caretaker_alerts INNER JOIN animal ON caretaker_alerts.animal_id = animal.animal_id WHERE caretaker_id = ";
  sql += employee.username;
  if(time != "allTime")
  {
    var amt = 1;
    if(time == "week")
      amt = 7;
    else if(time == "month")
      amt = 31;
    else if(time == "year")
      amt = 365;
    sql += " AND caretaker_alerts.date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
    sql += amt;
    sql += " DAY ))";
  }
  sql += " ORDER BY caretaker_alerts.date_generated ASC";
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) console.log(err);
      else
      {
        var sql2 = "SELECT COUNT(*) AS numHealthy FROM caretaker_alerts WHERE new_health_status='healthy' AND caretaker_id = ";
        sql2 += employee.username;
        if(time != "allTime")
        {
          sql2 += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
          sql2 += amt;
          sql2 += " DAY ))";
        }
        pool.getConnection(function(err, connection){
          connection.query(sql2, function(err, res2){
            connection.release();
            if(err) console.log(err);
            else
            {
              var sql3 = "SELECT COUNT(*) AS numSick FROM caretaker_alerts WHERE new_health_status='sick' AND caretaker_id = ";
              sql3 += employee.username;
              if(time != "allTime")
              {
                sql3 += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
                sql3 += amt;
                sql3 += " DAY ))";
              }
              pool.getConnection(function(err, connection){
                connection.query(sql3, function(err, res3){
                  connection.release();
                  if(err) console.log(err);
                  else
                  {
                    var sql4 = "SELECT COUNT(*) AS numPregnant FROM caretaker_alerts WHERE new_health_status='pregnant' AND caretaker_id = ";
                    sql4 += employee.username;
                    if(time != "allTime")
                    {
                      sql4 += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
                      sql4 += amt;
                      sql4 += " DAY ))";
                    }
                    pool.getConnection(function(err, connection){
                      connection.query(sql4, function(err, res4){
                        connection.release();
                        if(err) console.log(err);
                        else
                        {
                          var sql5 = "SELECT COUNT(*) AS numDeceased FROM caretaker_alerts WHERE new_health_status='deceased' AND caretaker_id = ";
                          sql5 += employee.username;
                          if(time != "allTime")
                          {
                            sql5 += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
                            sql5 += amt;
                            sql5 += " DAY ))";
                          }
                          pool.getConnection(function(err, connection){
                            connection.query(sql5, function(err, res5){
                              connection.release();
                              if(err) console.log(err);
                              else
                              {
                                callback(res, res2, res3, res4, res5);
                              }
                            })
                          });
                        }
                      });
                    });
                  }
            });
          });
        }
      });
    });
}
});
});
}
module.exports.getCareTakerAlerts = getCareTakerAlerts;

getVetAlerts = function(time, callback)
{
  var sql = "SELECT zoo_supply_alerts.product_id, DATE_FORMAT(zoo_supply_alerts.date_generated, '%Y-%m-%d') AS date_generated, medicine_supply.med_name AS medName FROM zoo_supply_alerts INNER JOIN medicine_supply ON zoo_supply_alerts.product_id = medicine_supply.med_id WHERE manager_id=10008";
  if(time != "allTime")
  {
    var amt = 1;
    if(time == "week")
      amt = 7;
    else if(time == "month")
      amt = 31;
    else if(time == "year")
      amt = 365;
    sql += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
    sql += amt;
    sql += " DAY ))";
  }
  sql += " ORDER BY date_generated ASC";
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) console.log(err);
      else
        callback(res);
    });
});
}
module.exports.getVetAlerts = getVetAlerts;


getNutritionAlerts = function(time, callback)
{
  var sql = "SELECT zoo_supply_alerts.product_id, DATE_FORMAT(zoo_supply_alerts.date_generated, '%Y-%m-%d') AS date_generated, food_supply.food_name AS foodName FROM zoo_supply_alerts INNER JOIN food_supply ON zoo_supply_alerts.product_id = food_supply.food_id WHERE manager_id=10001";
  if(time != "allTime")
  {
    var amt = 1;
    if(time == "week")
      amt = 7;
    else if(time == "month")
      amt = 31;
    else if(time == "year")
      amt = 365;
    sql += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
    sql += amt;
    sql += " DAY ))";
  }
  sql += " ORDER BY date_generated ASC";
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) console.log(err);
      else
        callback(res);
    });
});
}
module.exports.getNutritionAlerts = getNutritionAlerts;


getStoreManagersAlerts = function(id, time, callback)
{
  var sql = "SELECT store_supply_alerts.product_id,store_supply_alerts.product_size, DATE_FORMAT(store_supply_alerts.date_generated, '%Y-%m-%d') AS date_generated, product.product_name FROM store_supply_alerts INNER JOIN product ON store_supply_alerts.product_id = product.product_id WHERE store_supply_alerts.manager_id = ";
  sql += id;
  if(time != "allTime")
  {
    var amt = 1;
    if(time == "week")
      amt = 7;
    else if(time == "month")
      amt = 31;
    else if(time == "year")
      amt = 365;
      sql += " AND date_generated >= (SELECT DATE_SUB(DATE(NOW()), INTERVAL ";
      sql += amt;
      sql += " DAY ))";
  }
  sql += " ORDER BY date_generated ASC";
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) console.log(err);
      else
        callback(res);
    });
});
}
module.exports.getStoreManagersAlerts = getStoreManagersAlerts;



/* --------------------------------------------------------------------------- */

searchOrder = function(number, zipcode, callback)
{
  var sql = "SELECT `order`.*, product.product_name, product.image_path FROM `order` JOIN product ON `order`.product_id=product.product_id WHERE order_id = ";
  sql += number;
  sql += " AND zipcode = ";
  sql += zipcode;
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) callback(false);
      else
        callback(res);
    });
  });
}
module.exports.searchOrder = searchOrder;


getCustomerInfo = function(email, callback)
{
  var sql = "SELECT f_name, isMember, DATE_FORMAT(memberUntil,'%d-%m-%Y') AS memberUntil, DATE_FORMAT(date_registered,'%d-%m-%Y') AS date_registered FROM customer WHERE email = '";
  sql += email;
  sql += "';"
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) callback(false);
      else
        callback(res);
    });
  });
}
module.exports.getCustomerInfo = getCustomerInfo;


getOrderHistory = function(email, callback)
{
  var sql = "SELECT `order`.order_id, `order`.product_id, `order`.order_date, `order`.price_total, `order`.quantity, `order`.product_size, `order`.order_status, DATE_FORMAT(`order`.order_date, '%d-%m-%Y') AS order_date, product.product_name, product.image_path FROM `order` JOIN product ON `order`.product_id=product.product_id WHERE email = '";
  sql += email;
  sql += "' ORDER BY order_date DESC;"
  pool.getConnection(function(err, connection){
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err, res){
      connection.release();
      if(err) callback(false);
      else
        callback(res);
    });
  });
}
module.exports.getOrderHistory = getOrderHistory;


getMembership = function(callback)
{
  var sql = "SELECT * FROM product WHERE product_id = 37378708;"
  pool.getConnection(function(err, connection){
    if(err) {console.log(err); callback(true); return;}
    connection.query(sql, function(err, res){
      connection.release();
      if(err) callback(false);
      else
        callback(res);
    });
  });
}
module.exports.getMembership = getMembership;

//allows employees to update product stock
getProductsForUpdate = function(dept, callback){
  var sql = "SELECT * FROM product WHERE gift_shop_id = ";
  sql += dept;
  sql += " GROUP BY product_id";
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err,res){
      if(err){callback(false);}
      if(res.length)
        callback(res);
      else
        callback(false);
    });
  });
}
module.exports.getProductsForUpdate = getProductsForUpdate;

updateStock = function(id, size, quantity, callback){
  var sql = "UPDATE product SET stock = stock + ";
  sql += quantity;
  sql += " WHERE product_id = ";
  sql += id;
  sql += " AND product_size = '";
  sql += size;
  sql += "';";
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(true); return; }
    connection.query(sql, function(err,res){
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.updateStock = updateStock;

// updating medicine stock
getMedicine = function(id, callback)
{
  var sql = "SELECT animals_on_medicine.*, DATE_FORMAT(DATE_ADD(animals_on_medicine.last_prescribed, INTERVAL duration_days DAY), '%M-%d-%Y') AS takeUntil, medicine_supply.med_name, medicine_supply.stock,medicine_supply.target_stock, animal.animal_name FROM animals_on_medicine JOIN medicine_supply ON animals_on_medicine.med_id = medicine_supply.med_id JOIN animal ON animals_on_medicine.animal_id = animal.animal_id WHERE DATE_ADD(animals_on_medicine.last_prescribed, INTERVAL duration_days DAY)>=DATE(NOW()) AND animals_on_medicine.animal_id = ";
  sql += id; 
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.getMedicine = getMedicine;


giveMedicine = function(id, doses, doseAmount, callback)
{
  var sql = "UPDATE medicine_supply SET stock = stock - ";
  sql += doses * doseAmount;
  sql += " WHERE med_id = ";
  sql += id;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.giveMedicine = giveMedicine;

// functions for caretakers to update food stock by feeding animals

getFood = function(id, callback)
{
  var sql = "SELECT animal_diet.*, food_supply.food_name, food_supply.stock,food_supply.target_stock, animal.animal_name FROM animal_diet JOIN food_supply ON animal_diet.food_id = food_supply.food_id JOIN animal ON animal_diet.animal_id = animal.animal_id WHERE animal_diet.animal_id = ";
  sql += id;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.getFood = getFood;

giveFood = function(id, servings, servingAmount, callback)
{
  var sql = "UPDATE food_supply SET stock = stock - ";
  sql += servings * servingAmount;
  sql += " WHERE food_id = ";
  sql += id;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.giveFood = giveFood;


// functions to let caretaker manager assign caretakers to animals
getAllCaretakers = function(callback)
{
  var sql = "SELECT employee_id, first_name, last_name FROM employee WHERE department_id = 15";
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.getAllCaretakers = getAllCaretakers;

assignAnimalToCaretaker = function(animal, caretaker, callback)
{
  var sql = "INSERT INTO takes_care_of(caretaker_id, animal_id) VALUES (";
  sql += caretaker;
  sql += ",";
  sql += animal;
  sql += ");"
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.assignAnimalToCaretaker = assignAnimalToCaretaker;


prescribeMedicine = function(animal, medicine, dose, frequency, duration, disease, callback)
{
  var sql = "INSERT INTO animals_on_medicine(animal_id, med_id, dose_amount_mg, dose_frequency, last_prescribed, duration_days,disease) VALUES(";
  sql += animal;
  sql += ",";
  sql += medicine;
  sql += ",";
  sql += dose;
  sql += ",'";
  sql += frequency;
  sql += "',";
  sql += "DATE(NOW()),";
  sql += duration;
  sql += ",'";
  sql += disease;
  sql += "');";
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.prescribeMedicine = prescribeMedicine;


// functions that update food and med stock
updateMedStock = function(med, quantity, callback)
{
  var sql = "UPDATE medicine_supply SET stock = stock + ";
  sql += quantity;
  sql += " WHERE med_id = ";
  sql += med;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.updateMedStock = updateMedStock;


getAnimalInfo = function(animal, callback){
  var sql = "SELECT * from zoo_schema.animal WHERE animal_id=";
  sql+= animal;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}

module.exports.getAnimalInfo = getAnimalInfo;


updateAnimalInfo = function(animal, data, callback)
{
  var sql = "UPDATE zoo_schema.animal SET enclosure_id ="
  sql+=data[0];
  sql+=", status =";
  sql+=data[1];
  sql+=", diet_type =";
  sql+=data[2];
  sql+=", feedings_per_day =";
  sql+=data[3];
  sql+=" WHERE animal_id =";
  sql+=animal;
  
   pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
        connection.query(sql, function(err,res){
          connection.release();
          if(err){callback(false);}
          callback(res);
        });
      });
 }
module.exports.updateAnimalInfo = updateAnimalInfo;


updateFoodStock = function(food, quantity, callback)
{
  var sql = "UPDATE food_supply SET stock = stock + ";
  sql += quantity;
  sql += " WHERE food_id = ";
  sql += food;
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.updateFoodStock = updateFoodStock;


// vets can assign food to an animal
assignFood = function(animal, food, serving, frequency, callback)
{
  var sql = "INSERT INTO animal_diet(animal_id,food_id,serving_size_in_grams,servings_per_day) VALUES (";
  sql += animal;
  sql += ", ";
  sql += food;
  sql += ", ";
  sql += serving;
  sql += ", ";
  sql += frequency;
  sql += ");";
  pool.getConnection(function (err, connection) {
    if(err) { console.log(err); callback(false); return; }
    connection.query(sql, function(err,res){
      connection.release();
      if(err){callback(false);}
      callback(res);
    });
  });
}
module.exports.assignFood = assignFood;