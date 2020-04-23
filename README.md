# ZooDB
Zoo DBMS for Databases Course
Online Link: (http://ec2-18-224-190-30.us-east-2.compute.amazonaws.com:3000)
# User Roles
All users have password set as ***password***.  

***Login Information***  
Login as a customer by clicking Login then Customer Login from home page.  
***johndoe@gmail.com - Customer***  
Logout from customer by going to home page and selecting Login | Logout and pick the Logout option.  

Login as employee by clicking Login then Employee Login from home page.  
***10015*** - Vet Alondra Aguilar  
***10008*** - Vet Manager Charlotte de Witte  
***10001*** - Nutrition Manager Andrew Jones  
***10014*** - Caretaker Asucena Ochoa  
***10010*** - Caretaker Manager Chris Jamez  
***10018*** - Normal Employee Sam Arnold  
Logout as employee by clicking the name in the top right and selecting logout option.  

#What can each role can Do?  
***Vet*** -   
***Vet Manager*** -   
***Caretaker*** -    
***Caretaker Manager*** -   
***General Manager*** -  
***Regular Zoo Employee *** -   


### SETUP INFORMATION  

# Setting up the database  
This project uses mySql and uses the schema called zoo_schema   

# Running the Server  
First of all make sure you have Node installed on your computer. You can get it from here https://nodejs.org/en/download/   
then you can try doing node -v in the terminal to see if it installed correctly  

Now get the files from github using git clone or download.  

cd into the ZooDB folder

In the folder you will see the package.json file which contains all the dependencies needed to make the project run. 
Currently there is mysql, express and body-parser which are for the server. 
If you ever add any dependencies/packages make sure you run **npm install package_name --save** from the root directory
and it will automatically add it to the package.json file.

Run **npm install** to download all the dependencies locally. You should get a folder created called node_modules. It contains all the info needed for all the dependencies to run and there is alot of files inside it. 
For this reason it is excluded from the github repo or else the repo size would be much larger. 

Run **node app.js** you should see "App listening on port 3000". After that you can test the website
by typing localhost:3000 into a web browser and you should see the home page of the app. If all that works then the app is configured properly on your computer.



