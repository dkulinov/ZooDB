# ZooDB
Zoo DBMS for COSC 3380







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

Run **node app.js** you should see "App listening on port 3000" and "Connected to mysql Server" After that you can test the website
by typing localhost:3000 into a web browser and you should see the home page of the app. If all that works then the app is configured properly on your computer.



