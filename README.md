# Rentle 
by Shashhank Seethula, Phuc Thinh Nguyen, Alicia Shi

## Description
Rentle is a rental application that allows users to rent out different items from other people. By bringing renters and rental suppliers together, Rentle provides a cheaper alternative to purchasing items.

## Rentle Demo
https://github.com/user-attachments/assets/a79ec689-479b-42e7-ad62-2f1fef8064b8

## Features
* Account management
* Renter Perspective
  * Can rent out items for a specific time slot
  * Can message rental suppliers
  * Search using advanced filters
  * Leave reviews on rental suppliers
  * Ask an AI chatbot for recommendations
  * Can friend different users
  * View previous rentals
* Rental Supplier Perspective
  * Can list items for rental and decide prices by hour, day, week, etc
  * Can message renters
  * Leave reviews on renters

## Images
Search with various filters
![image0](https://github.com/user-attachments/assets/cd2c8e5d-7f9a-48af-a9f0-11ea92a2173e)

Account Login
![image1](https://github.com/user-attachments/assets/78d99c1d-d278-4f77-9dab-01944744acb6)

View Rentals
![image2](https://github.com/user-attachments/assets/1a31db4c-d9f3-435b-a0e3-6409c3b3b053)

Checkout Rental
![image3](https://github.com/user-attachments/assets/46b2d504-ed8d-4e19-aa85-858e6fe14dce)

Past Rentals
![image4](https://github.com/user-attachments/assets/01680d4c-9180-4b62-9f92-e3848f3ff45b)

Current Rentals
![image4](https://github.com/user-attachments/assets/f157483f-1cad-4394-b9df-0b3463902a62)

Listing an Item
![image5](https://github.com/user-attachments/assets/a431e20d-8e6d-425c-ab40-c5aa92d5be79)

Adding Reviews
![image6](https://github.com/user-attachments/assets/ef4cd63c-b6f4-4d0d-8ef9-7b7b7d2b4d2e)

Message System
![image7](https://github.com/user-attachments/assets/4830649c-8d07-441e-8957-e8070a98f655)

Friend System
![image8](https://github.com/user-attachments/assets/4e979b71-7a50-4dfd-9dd9-7ef3e743af9c)

AI Assistant for Recommendations
![image9](https://github.com/user-attachments/assets/db397b90-48af-406a-b56f-25501c429ee3)

## Requirements
* Tomcat 10
* MySQL configured on port 3306 with JDBC in lib folder
* Working Java Version with the ability to use terminal commands involving Java.
  
## Setup
1. Download project files
2. Put Rentle folder in the webapps folder of Apache Tomcat
3. Change all instances of "Hello1234!" to your own database password and add any necessary API keys if needed such as Google Maps and ChatGPT.
4. Put all additional lib files in the lib folder of Apache Tomcat along with personal jar files such as JDBC.
5. Open Rentle/JavaMessageFiles
6. Copy the .java files into the lib folder of Apache Tomcat
7. Open the lib folder in terminal and run: `javac -cp "PATH_TO_LIB_FOLDER" *.java` replacing the file path with your own path
8. Go to the lib folder and copy and paste all .class files into the WEB-INF/class folder within webapps/Rentle
9. Start Tomcat server and go to http://localhost:8080/Rentle/
