const express = require('express');
const app = express();
const port = 3000;
var path = require('path');
var db = require('../server/db.js') 

//used to get the correct directory which is the root directory 
app.use(express.static(path.join(__dirname, '/../')));

//allows us to use data send from html forms using req.body.name
app.use(express.urlencoded({ extended: false }));

//default route will point to index.html which is the homepage
app.get('/', (req, res) => res.sendFile(index.html));



app.get('/employeelogin', function(req, res) {
    res.send('temp link for login page');
});

/*
test connection to query from database and return data
you can test the connection by downloading postman and performing 
a post request on the url localhost:3000/test
*/
app.post('/test',function(req, res) {
    db.testConnection(function(err, data){
        if(err) {console.log("error"); return;}
        else{
            res.send(data);  //result of the query will be displayed
        }
    });
});
  
// catch all route that will notify the user that this page doesn't exist
app.get('*', function(req, res){
    res.render(wrongRoute.html);
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));    
