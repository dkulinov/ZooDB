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
app.get((req, res) => res.sendFile("index.html"));

app.get('/employeeLogin', function(req, res){
    res.render('employeeLogin');
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

//on submit of the employee login form
 app.post('/employeeLogin', function(req, res){
    var username = req.body.username;
    var password = req.body.password;
    //either username or password is blank
    if(!username || !password){
       res.send("Error missing username or password");
    } else {
        db.authenticateEmployee([username, password], function(err, data){
            if(err) {console.log("error"); return;}
            else{
              
                if(data === true){
                    req.session.user = new user(username, "Employee");
                    db.getEmployeeInfo(req.session.user, assignEmployeeInfo, function()
                    {
                        if(req.session.user.isManager)   // will be for managers only
                            res.redirect('/managerFrontPage');
                        else if(req.session.user.isCareTaker || req.session.user.dept == 9)
                            res.redirect('/caretakerAndVet'); // will be for caretakers and vets only
                        else
                            res.redirect('/regularEmployee'); // will be for regular employees
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
       res.send("Error missing username or password");
    } else {
        db.authenticateCustomer([username, password], function(err, data){
            if(err) {console.log("error"); return;}
            else{

                if(data === true){
                    req.session.user = new user(username, "Customer");
                    res.redirect("/");
                    
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


/* --------------------------------------- Manager Page Routes  ----------------------------------------- */

app.get('/managerFrontPage',checkEmployeeSignIn, function(req,res)
 {   
     res.render("manager_frontPage");
 });
app.get('/managerTables',checkEmployeeSignIn, function(req,res)
{   
    var data = []   //used to pass to the manager_table ejs file

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
app.get('/managerCharts', checkEmployeeSignIn, function(req,res)
{   
    res.render("manager_charts");
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
app.use('/managerCharts', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
});

//manager report routes
app.get('/dailyReport', checkEmployeeSignIn, function(req,res)
{   
    var data = [];
    db.getDailyRevenue(function(revenue)
    {
        data.dailyRevenue = revenue;
        console.log(data);
        res.render("dailyReport", {data: data});
    });

});
app.get('/monthlyReport', checkEmployeeSignIn, function(req,res)
{   
    var data = [];
    db.getMonthlyRevenue(function(revenue)
    {
        data.monthlyRevenue = revenue;
        console.log(data);
        res.render("monthlyReport", {data: data});
    });
});

app.get('/cumulativeReport', checkEmployeeSignIn, function(req,res)
{   
    var data = [];
    db.getCumulativeRevenue(function(revenue)
    {
        data.cumulativeRevenue = revenue;
        console.log(data);
        res.render("cumulativeReport", {data: data});
    });

});

app.use('/dailyReport', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
});
app.use('/monthlyReport', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
});
app.use('/cumulativeReport', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/employeeLogin');
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

/*------------------------------------------------------------ */





// catch all route that will notify the user that this page doesn't exist
// this has to remain the on the bottom
app.get('*', function(req, res){
    res.render('wrongRoute');
});

app.listen(port, () => console.log(`App listening on port ${port}!`));
