var AWS = require('aws-sdk')
// Set region for AWS SDKs
AWS.config.region = process.env.REGION

var express = require('express');
var session = require('express-session');
var app = express();
var port = process.env.PORT || 3000;
var path = require('path');
var db = require('./server/db.js'); 

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");

// ----------------------------- MIDDLEWARE -------------------------------- //

//used to get the correct directory which is the root directory 
app.use(express.static(path.join(__dirname, './')));

//allows us to use data send from html forms using req.body.name
app.use(express.urlencoded({ extended: false }));

//each user has a different session so we can keep track of them no matter where they are on the site
app.use(session({secret: "SecretKey"}));

//use the ejs files in the views folder however 
app.set('view engine', 'ejs');

//redefine views folder to the right path
app.set('views', path.join(__dirname, './views'));

// ------------------------------------------------------------------------- //


//for creating a express session for each user 
function user(username, role, dept=-1, isManager=false, isCareTaker=false) {
   this.username = username;
   this.role = role;  //is the user an employee or customer
   this.dept = dept;
   this.isManager = isManager;
   this.isCareTaker = isCareTaker;
 }


function assignEmployeeInfo(emp, dept, isM, isC, cb)
{
    emp.dept = dept;
    if(isM > 0)
        emp.isManager = true;
    if(isC > 0)
        emp.isCareTaker = true;
    cb();
}


// ----------------------------- ROUTES -------------------------------- //
//default route will point to index.html which is the homepage

app.get('/', function(req, res){
    
    if(!req.session.user)
    {
        console.log('hello');
        res.sendFile(path.join(__dirname,'/main.html'));
    }
    else if(req.session.user.role == "Customer")
        res.redirect('/customerFrontPage');
    else if(req.session.user.role == "Employee"){
        if(req.session.user.isManager)
        {
            if(req.session.user.dept==9) 
                res.redirect('/vetManager');
            else if(req.session.user.isCareTaker) 
                res.redirect('/caretakerManager');
            else 
                res.redirect('/managerFrontPage',);
        }
        else if(req.session.user.isCareTaker)
        {
                res.redirect('/caretaker');
        }
        else if(req.session.user.dept === 9){
            res.redirect('/vet');
        }
        else
            res.redirect('/regularEmployee');
    }
});


app.post('/signup', function(req, res){
   //if one of the sign up fields is blank it wont work
   if(!req.body.firstName, !req.body.lastName, !req.body.email, !req.body.password){
      res.render('errorPage', {message: "Error one of the fields are missing."});   
   }
   db.signUpCustomer([req.body.firstName, req.body.lastName, req.body.email, req.body.password], function(err, data){
      if(err) {console.log("error"); return;}
      else{
        
          if(data === true){
              res.redirect("/customerLogin");
              
          }else{
              res.render('errorPage', {message: "Error user with that email already exists."});  //user already exists with this email
          } 
      }
  }); 
});

app.get('/employeeLogin', function(req, res){
    res.render('employeeLogin');
 });

//on submit of the employee login form
app.post('/employeeLogin', function(req, res){
    var username = req.body.username;
    var password = req.body.password;
    //either username or password is blank
    if(!username || !password){
        res.render('errorPage', {message: "Missing required fields"});
    } else {
        db.authenticateEmployee([username, password], function(err, data){
            if(err) {console.log("error"); return;}
            else{
              
                if(data === true){
                    req.session.user = new user(username, "Employee");
                    db.getEmployeeInfo(req.session.user, assignEmployeeInfo, function()
                    {
                        res.redirect('/');             
                    });
                }else{
                  res.render('errorPage', {message: "Wrong username or password"});
                    
                } 
            }
        });
    }
 });



app.get('/employeeLogout', function(req, res){
    req.session.destroy(function(){
       console.log("user logged out.")
    });
    res.redirect('/employeeLogin');
 });

/* pretty much copy paste of the employee login above but for customers instead of employees*/
app.get('/customerLogin', function(req, res){
    res.render('customerLogin');
});

//on submit of the login form this will be run to authenticate customer
app.post('/customerLogin', function(req, res){
    var username = req.body.username;
    var password = req.body.password;

    //either username or password is blank
    if(!username || !password){
        res.render('errorPage', {message: "Missing required fields"});
    } else {
        db.authenticateCustomer([username, password], function(err, data){
            if(err) {console.log("error"); return;}
            else{

                if(data === true){
                    req.session.user = new user(username, "Customer");
                    res.redirect("/customerFrontPage");
                    
                }else{
                  res.render('errorPage', {message: "Wrong username or password"});
                    
                } 
            }
        });     
        
    }
 });

app.get('/customerLogout', function(req, res){
    req.session.destroy(function(){
       console.log("user logged out.")
    });
    res.redirect('/customerLogin');
 });



// ------------------------------------------------------------------------- //


/* can be used in each route to see if the user is logged in */
function checkCustomerSignIn(req, res, next){
   if(!req.session.user){
      var err = new Error("Not logged in!");
      next(err);
   }
   else if(req.session.user.role === "Customer"){
      
      next();   //If session exists, proceed to page
   }else {
      var err = new Error("Not logged in!");
      next(err);
   }
}


/* can be used in each route  to see if the user is logged in and if it is an employee*/
function checkEmployeeSignIn(req, res, next){
   if(!req.session.user){
      var err = new Error("Not logged in!");
      next(err);
   }
   else if(req.session.user.role === "Employee"){
      
       next();   //If session exists, proceed to page
   }else {
      var err = new Error("Not logged in!");
      next(err);
   }
}

/*---------------------------------------- Regular Employee Page Routes ----------------------------------*/
/*app.get('/regularEmployee', checkEmployeeSignIn, function(req, res)
{
        res.render("regEmployee_page");
})
*/




/*---------------------------------------- Caretaker and Vet Page Routes ----------------------------------*/

app.get('/caretaker',checkEmployeeSignIn, function(req,res)
{
    var data = [];
    var username = req.session.user;

    db.getEmployeeName(username, function(employee){
        data.employee = employee;
    });
    

    db.getEmployeesAnimals(username, function(animals){
        data.animals = animals;
        res.render("caretaker.ejs", { data: data });
    });
     
});

app.get('/caretakerManager',checkEmployeeSignIn, function(req,res)
{
    var data = [];
    var username = req.session.user;

    db.getEmployeeName(username,function(employee){
        data.employee = employee;
    });

    db.getCareTakersInfo(function(caretakers){
        data.caretakers = caretakers;
        res.render("caretakerManager.ejs", { data: data });
    });
     
});

app.get('/vet',checkEmployeeSignIn, function(req,res)
{
    var data = [];
    var username = req.session.user;

    db.getEmployeeName(username,function(employee){
        data.employee = employee;
    });
    
    db.getAllAnimals(function(animals){
        data.animals = animals;
        res.render("vet.ejs", { data: data });
    });
     
});

app.get('/vetManager',checkEmployeeSignIn, function(req,res)
{
    var data = {};
    var username = req.session.user;

    db.getEmployeeName(username,function(employee){
        data.employee = employee;
    });

    db.getAllAnimals(function(animals){
        data.animals = animals;
        console.log(data);
    });

    db.getAllEmployees(function(employees)  //get employees from db.js file and then call the function 
    {
       data.employeeList = employees;
        
    });
    
    db.getEmployeesAnimals(username,function(animals){
        data.animals = animals;
        console.log(data.animals)
        res.render("vetManager.ejs", { data });
    });
     
});


app.get('/vetTables',checkEmployeeSignIn, function(req,res){
    var data = [];
    db.getEmployeeName(req.session.user,function(employee){
        data.employee = employee;
    });
    db.getAllAnimals(function(animalList){
        data.animalList = animalList;
    });
    db.getFoodStock(function(foodStock){
        data.foodStock = foodStock;
    });
    db.getMedicineStock(function(medicineStock){
        data.medicineStock = medicineStock;
        res.render("vet_tables.ejs", {data :data});
    });
});






/* --------------------------------------- Manager Page Routes  ----------------------------------------- */

app.get('/managerFrontPage',checkEmployeeSignIn, function(req,res)
 {   
     var userid = req.session.user;
     const emp_name = [];

     db.getEmployeeName(userid, function(emp_name){
         res.render("manager_frontPage", {emp_name: emp_name});
     });
    
 });

app.get('/managerTables',checkEmployeeSignIn, function(req,res)
{   
    var data = [];   //used to pass to the manager_table ejs file

    db.getAllEmployees(function(employees)  //get employees from db.js file and then call the function 
    {
       data.employeeList = employees;
        
    });
    db.getFoodStock(function(foodStock)  
    {
        data.foodStock = foodStock;

    });
    db.getMedicineStock(function(medicineStock)  //after running the last query we render the page
    {
        data.medicineStock = medicineStock;
        res.render("manager_tables", { data: data });
    });

});

//these 3 routes are if the user isnt logged in it redirects them to employeeLogin
app.use('/managerFrontPage', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
});

app.use('/managerTables', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
});

//this route generates a report between a start date and end date which comes from an html form
 app.post('/generateReport', function(req, res){
    var startdate = req.body.startdate;
    var enddate = req.body.enddate;
 
    var data = [];    
    if(!startdate || !enddate){
        res.render('errorPage', {message: "Missing required fields"});
    } else {

        db.getRevenueTest([startdate, enddate], function(err,revenue){
            if(err) {console.log("error"); return;}
            else{
                data.revenue = revenue;
                db.getOrdersTest([startdate, enddate], function(err,orders){
                    if(err) {console.log("error"); return;}
                    else{
                        data.orderTable = orders;
                        db.getMostSoldProductsTest([startdate, enddate], function(err,products){
                            if(err) {console.log("error"); return;}
                            else{
                                data.mostSoldProducts = products;
                                db.getTicketDistribution([startdate, enddate], function(err,tickets){
                                    if(err) {console.log("error"); return;}
                                    else{
                                        data.ticketDistribution = tickets;
                                        res.render("financialReport", {data: data});
                                    }
                                });
                            }
                        });
                    }
                }); 
            }
        });     
  
 
    }
 });

/*------------------------------------------------------------ */





/* --------------------- Shop Routes  ------------------------- */
app.get('/shop', function(req,res)
{   
    var items = [];
    db.getProducts(function(items)
    {
        res.render("shop.ejs", {items: items});
    });
});

app.post('/checkout/:id/:size/:price/:imagepath/', function(req,res)
{
    var cart = {id: req.params.id, size: req.params.size, price: req.params.price, quantity: req.body.quantity, image_path: req.params.imagepath};
    if(!req.session.user)
        res.render("checkout.ejs", {cart: cart});
    else if(req.session.user.role == "Employee")
        res.render("in_storeCheckout.ejs",{cart: cart});
    else
        res.render("checkout.ejs",{cart: cart});
});

app.post('/buy/:id/:size/:quantity/:total/:in_store', function(req,res)
{
    var newID;
    var order = {product_id: req.params.id, product_size: req.params.size, quantity: req.params.quantity, total: req.params.total, email: req.body.email, address: req.body.address, city: req.body.city, state: req.body.state, zipcode: req.body.zip, in_store : req.params.in_store};
    if(order.in_store == 0)
    {
        db.makeOnlinePurchase(order, function(response){
            newID = response;
            newID = newID.insertId;
            res.render("confirmation.ejs", {newID:newID});
        });
    }
    else
    {
        db.ringUpCustomer(order, function(response){
            newID = response;
            newID = newID.insertId;
            res.render("confirmation.ejs", {newID:newID});
        });
    }
});






/* --------------------- Alert Routes  ----------------------- */
app.get('/alertOptions/', function(req, res)
{
    if(!req.session.user)
        res.render('errorPage', {message: "You don't have access to this page!"});
    else if(req.session.user.role == "Customer")
        res.render('errorPage', {message: "You don't have access to this page!"});
    else if(req.session.user.role == "Employee")
    {
        if(req.session.user.isManager || req.session.user.isCareTaker || req.session.user.dept==9)
            res.render('alertOptions.ejs');
        else
            res.render('errorPage', {message: "You don't have access to this page!"});
    }
});


app.post('/alert', function(req, res)
{
    if(req.session.user.dept == 9)
    {
        db.getVetAlerts(req.body.time, function(info)
        {
            console.log(info);
            res.render('vet_alerts.ejs', {data:[info, req.body.time]});
        });
    }
    else if(req.session.user.isCareTaker)
    {
        // render caretaker report
        db.getCareTakerAlerts(req.session.user, req.body.time, function(alerts, numHealthy, numSick, numPregnant, numDeceased)
        {
            res.render('caretaker_alerts.ejs', {data:[alerts, req.body.time, numHealthy, numSick, numPregnant,numDeceased]});
        });
    }
    else if(req.session.user.isManager)
    {
        // render manager reports
        // may have to differentiate based on departments
        if(req.session.user.dept == 12)
        {
            db.getNutritionAlerts(req.body.time, function(info)
            {
                res.render('nutrition_alerts.ejs', {data:[info, req.body.time]});
            });
        }
        else if(req.session.user.dept >=5 && req.session.user.dept <=7)
        {
            db.getStoreManagersAlerts(req.session.user.username, req.body.time, function(info)
            {
                res.render('manager_alerts.ejs', {data:[info, req.body.time]});
            });
        }
        else
            res.render('errorPage', {message: "You don't have access to this page!"}); // any other managers
    }
});


/* --------------------- Tracking Routes  ----------------------- */

// search 1 order
app.get('/searchOrderStatus', function(req, res)
{
    res.render('searchOrderStatus.ejs');
});

app.post('/searchOrder', function(req, res)
{
    db.searchOrder(req.body.number, req.body.zip, function(data)
    {
        if(data != false)
            res.render('order_status.ejs', {data:data});
        else
            res.render('errorPage', {message: "We couldn't find your order!"});
    })
});


app.get('/customerFrontPage', function(req, res)
{
    if(!req.session.user)
        res.render('errorPage', {message: "Please sign in or create an account"});
    else if(req.session.user.role == "Employee")
        res.render('errorPage', {message: "You're not a customer"});
    else if(req.session.user.role == "Customer")
    {
        db.getCustomerInfo(req.session.user.username, function(data)
        {
            res.render('customerFrontPage.ejs', {data:data});
        });
    }
});


app.get('/orderHistory', function(req, res)
{
    if(!req.session.user)
        res.send("Please sign in or create an account");
    else if(req.session.user.role == "Employee")
        res.send("You're not a customer");
    else if(req.session.user.role == "Customer")
    {
        db.getOrderHistory(req.session.user.username, function(data)
        {
            res.render('orderHistory.ejs', {data:data});
        });
    }
});


app.get('/getMembership', function(req,res)
{
    if(!req.session.user)
        res.render('errorPage', {message: "Please sign in or create an account"});
    else if(req.session.user.role == "Employee")
        res.render('errorPage', {message:"You're not a customer"});
    else if(req.session.user.role == "Customer")
    {
        db.getMembership(function(data)
        {
            res.render('becomeMember.ejs', {data:data});
        });
    }
});


// catch all route that will notify the user that this page doesn't exist
// this has to remain the on the bottom
app.get('*', function(req, res){
    res.render('wrongRoute');
});

app.listen(port, () => console.log(`App listening on port ${port}!`));
