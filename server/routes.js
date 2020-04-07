const express = require('express');
var session = require('express-session');
const app = express();
const port = 3000;
var path = require('path');
var db = require('../server/db.js') 

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");

// ----------------------------- MIDDLEWARE -------------------------------- //

//used to get the correct directory which is the root directory 
app.use(express.static(path.join(__dirname, '/../')));

//allows us to use data send from html forms using req.body.name
app.use(express.urlencoded({ extended: false }));

//each user has a different session so we can keep track of them no matter where they are on the site
app.use(session({secret: "SecretKey"}));

//use the ejs files in the views folder however 
app.set('view engine', 'ejs');

//redefine views folder to the right path
app.set('views', path.join(__dirname, '/../views'));

// ------------------------------------------------------------------------- //


//for creating a express session for each user 
function user(username, role) {
   this.username = username;
   this.role = role;  //is the user an employee or customer
 }


// ----------------------------- ROUTES -------------------------------- //
//default route will point to index.html which is the homepage
app.get('/', (req, res) => res.send("hi"));

app.get('/employeeLogin', function(req, res){
    res.render('employeeLogin');
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
                    res.send("Login Success");
                    
                }else{
                    res.send("Login Failed");
                    
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
                    res.send("Login Success");
                    
                }else{
                    res.send("Login Failed");
                    
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



/* can be used in each route  to see if the user is logged in and if it is an employee*/
function checkEmployeeSignIn(req, res){
   if(req.session.user.role === "Employee"){
      console.log(req.session.user.role);
       next();   //If session exists, proceed to page
   } else {
      console.log("error not logged in");
      next(err);
   }
}

/* can be used in each route  to see if the user is logged in */
function checkCustomerSignIn(req, res){
   if(req.session.user.role === "Customer"){
      console.log(req.session.user.role);
      next();   //If session exists, proceed to page
   } else {
      console.log("error not logged in");
      next(err);
   }
}

/* testing authentication in order to access a page */
 app.get('/protected_page', checkCustomerSignIn, function(req, res){
   res.send('Loaded protected page');
});

// ------------------------------------------------------------------------- //

app.use('/protected_page', function(err, req, res, next){
   console.log(err);
    //User should be authenticated! Redirect him to log in.
    res.redirect('/customerLogin');
 });


//GIFT SHOP ROUTES
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
    res.render("checkout.ejs", {cart: cart});
});

app.post('/buy/:id/:size/:quantity/:total/', function(req,res)
{
    var newID;
    var order = {product_id: req.params.id, product_size: req.params.size, quantity: req.params.quantity, total: req.params.total, email: req.body.email, address: req.body.address, city: req.body.city, state: req.body.state, zipcode: req.body.zip};
    db.makeOnlinePurchase(order, function(response){
        newID = response;
        newID = newID.insertId;
        res.render("confirmation.ejs", {newID:newID});
    });
});


// catch all route that will notify the user that this page doesn't exist
// this has to remain the on the bottom
app.get('*', function(req, res){
    res.render('wrongRoute');
});

app.listen(port, () => console.log(`App listening on port ${port}!`));    
