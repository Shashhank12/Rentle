# Rentle

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
