<%@ page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <title>Sign Up</title>
</head>
<body>
    <div id="main">
        <div id="leftwrap" class="main-child">
            <h1>Sign Up</h1>
            <p>Create an account to gain access to an endless catalog of items or to post your items for rent.</p>
            <a href="/home.jsp" id="continueasguest"><button>Or continue as guest</button></a>
        </div>
        <div id="rightwrap" class="main-child">
            <form action="/verify-id.jsp" id="sign-up-form">
                <label for="email" id="email-label">Email:</label>
                <input type="text" name="email" class="formtext" id="email">

                <label for="firstname" id="fname-label">First Name:</label>
                <input type="text" name="firstname" class="formtext" id="firstname">

                <label for="lastname" id="lname-label">Last Name:</label>
                <input type="text" name="lastname" class="formtext" id="lastname">

                <label for="username" id="username-label">Username:</label>
                <input type="text" name="username" class="formtext" id="username">
                
                <label for="password" id="password-label">Password:</label>
                <input type="password" name="password" class="formtext" id="password">
                
                <label for="role" id="role">Choose Account Type:</label>
                <fieldset id="role-radios">                    
                    <input type="radio" name="role-radios" value="renter" class="radiobuttons" id="renter-radio-button">
                    <label for="renter-radio-button" id="renter-radio-label">Renter</label>

                    <input type="radio" name="role-radios" value="rentee" class="radiobuttons" id="rentee-radio-button">
                    <label for="rentee-radio-button" id="rentee-radio-label">Rentee</label>
                </fieldset>

                <input type="submit" value="Sign Up" id="sign-up-submit" name="submit">
            </form>

            <a href="/sign-in.jsp" id="tosignin"><button> Already have an account?</button></a>
        </div>
    </div>
    <%
      String db = "RentalProj";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "ENTERYOURPASSWORDHERE"; //enter yourpass word
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentalProj?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");

            out.println("Initial entries in table \"Users\": <br/>");
            Statement stmt = con.createStatement();
            // ResultSet rs = stmt.executeQuery("SELECT * FROM User");

            if (request.getParameter("submit") != null) {
                out.println("Submit button clicked <br/>");

                // get form items
                String myEmail = (String)request.getParameter("email");
                String myPassword = (String)request.getParameter("password");
                String myFName = (String)request.getParameter("firstname");
                String myLName = (String)request.getParameter("lastname");

                String query = "INSERT INTO User (user_id, email, password, first_name, last_name, acc_type) VALUES (66, \'" + myEmail + "\', \'" + myPassword + "\', \'" + myFName + "\', \'" + myLName + "\', 'Renter');";

                int rs = stmt.executeUpdate(query);
                out.println(rs);
                // rs.close();   
            }
            stmt.close();
            con.close();
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage());
        }
    %>
</body>
</html>