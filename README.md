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

***10014*** - Caretaker Asucena Ochoa  

***10010*** - Caretaker Manager Chris Jamez  

***10013*** - General Manager

***10004*** - Clothing Shop Manager Katherine Gomez

***10016*** - Clothing Shop Employee John Smith

***10009*** - Kids' Shop Manager Daniel Evans

***10017*** - Kids' Shop Employee Judy Long

***10003*** - Accessories Shop Manager Travis Lee

***10018*** - Accessories Shop Employee Sam Arnold  

***10020*** - Ticket Shop Manager Jake Brown

***10019*** - Ticket Shop Employee Christopher Tick

Logout as employee by clicking the name in the top right and selecting logout option.  

#What can each role can Do?  

***Vet*** - Give animals Medicine (see animal named Hop and click "See current medicine"); Prescribe Medicine to any Animal; See animals' diet (see animal named Hop); Assign Food to an animal's diet; Update medicine Stock when shipment is received; Add a new medicine to the database; Add a new food to the database; See which medicines are runnning low on stock by clicking alerts.

***Vet Manager*** - Same capabilities as the regular vets by clicking the buttons on the left side. This will take you to the regular vet page and you can follow the instructions from the Vet info above. Additionally, vet manager can add new animals, edit animal information, and delete animals.

***Caretaker*** - See all the animals that they take care of. Feed them thereby updating the food stock. See caretaker alerts and caretaker report which shows how many health status changes occur.

***Caretaker Manager*** - Can update food stock as shipments are received. Can add new animals. Can assign animals to caretakers. Can view alerts

***General Manager*** -  Can view financial report.

***Shop Managers*** - Update the stock in their shop as shipments are received. See low stock alerts of products in their shops (except ticket shop because there's no stock). Add new items to their shops.

***Zoo Shop Employees*** - can ring people up depending on the gift shop they work in. Can also update product stock as "shipment is received".

***Customer*** - purchase products from the shop, become a member, view order history (all orders purchased under their email), track orders (if they have the order # and zipc ode). If a customer has a membership, they can extend it by another year by buying one more membership. Also if the customer has a membership they will not be able to buy tickets as all the tickets are free to them.

#SETUP INFORMATION  

## Setting up the database  
This project uses mySql and uses the schema called zoo_schema   

## Running the Server  
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



