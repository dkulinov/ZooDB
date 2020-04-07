const express = require('express');
var session = require('express-session');
const app = express();
const port = 3000;
var path = require('path');
var db = require('../server/db.js') 

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
app.get('/', (req, res) => res.sendFile("index.html"));

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
                    res.send("Login Success");   //should be changed based on the role of the user. Ex vet sees the vet page after logging in
                    
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



//inorder to access this page you need to be logged in as a customer 
app.get('/protected', checkCustomerSignIn, function(req, res){
   res.send("If you can see this then you are logged in as customer");
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
//if there is an error we call next(err) and it redirects back to customer login page
app.use('/protected', function(err, req, res, next){
    //User should be authenticated! Redirect him to log in.
    res.redirect('/customerLogin');
 });

// catch all route that will notify the user that this page doesn't exist
// this has to remain the on the bottom
app.get('*', function(req, res){
    res.render('wrongRoute');
});

app.listen(port, () => console.log(`App listening on port ${port}!`));    
