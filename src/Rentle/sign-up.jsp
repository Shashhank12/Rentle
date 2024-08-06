<%@ page import="java.sql.*,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <%
        String db = "rentle";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "Hello1234!"; //enter your password
    %>
    <title>Sign Up</title>
</head>
<body>
    <div id="main">
        <div id="leftwrap" class="main-child">
            <h1>Sign Up</h1>
            <p>Create an account to gain access to an endless catalog of items or to post your items for rent.</p>
            <a href="localhost:8080/Rentle" id="continueasguest"><button>Or continue as guest</button></a>
        </div>
        <div id="rightwrap" class="main-child">
            <form id="sign-up-form">
                <label for="email" id="email-label">Email:</label>
                <%
                    String myEmail = (String)request.getParameter("email");
                    Boolean emailInvalid = false;
                    try {
                        java.sql.Connection con;
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);
            
                        Statement stmt = con.createStatement();

                        String checkEmailQuery = String.format("SELECT COUNT(email) FROM user WHERE email='myEmail'", myEmail);
                        ResultSet rs = stmt.executeQuery(checkEmailQuery);
                        rs.next();
                        if (rs.getInt(1) == 1) {
                            emailInvalid = true;
                            %>
                            <p id="email-error" style="color: red;">Email is already in use</p>
                            <%
                        }
                        stmt.close();
                        con.close();
                    } catch(SQLException e) {
                        out.println("SQLException caught: " + e.getMessage());
                    }
                %>
                <input type="email" name="email" class="formtext" id="email">

                <label for="firstname" id="fname-label">First Name:</label>
                <input type="text" name="firstname" class="formtext" id="firstname">

                <label for="lastname" id="lname-label">Last Name:</label>
                <input type="text" name="lastname" class="formtext" id="lastname">
                
                <label for="password" id="password-label">Password:</label>
                <%
                    String myPassword = (String)request.getParameter("password");
                    Boolean passLengthCondition = (myPassword != null) && (myPassword.length() < 8);
                    Boolean passNumberCondition = (myPassword != null) && (!myPassword.matches(".*\\d.*"));
                    if (passLengthCondition) { //change to be a long list of illegal password conditions
                %>
                        <p id="password-error" style="color: red;">Password must be 8 characters or more</p>
                <%
                    } else if (passNumberCondition) {
                %>
                        <p id="password-error" style="color: red;">Password must include a number</p>
                <%
                    } 
                %>
                
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
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

            Statement stmt = con.createStatement();

            if (request.getParameter("submit") != null) {
                
                // get form items
                String myFName = request.getParameter("firstname");
                String myLName = request.getParameter("lastname");
                String accType = request.getParameter("role-radios");

                boolean allConditions = (!passLengthCondition) && (!passNumberCondition) && (!emailInvalid);

                if (allConditions) {
                    String idQuery = "SELECT user_id FROM user ORDER BY user_id DESC LIMIT 1";
                    ResultSet rs = stmt.executeQuery(idQuery);
                    rs.next();
                    int newID = rs.getInt(1) + 1;
                    out.println(newID);
                    rs.close(); 

                    int random = (int)(Math.random() * 999999 + 1);
                    String SALT = String.valueOf(random);

                    LocalDateTime now = LocalDateTime.now();

                    String query = String.format("INSERT INTO user (user_id, email, first_name, last_name, password, salt, creation_date) VALUES (%s, '%s', '%s', '%s', '%s', '%s', '%s');", String.valueOf(newID), myEmail, myFName, myLName, myPassword, SALT, now.toString());

                    int ri = stmt.executeUpdate(query);
                    
                    session.setAttribute("name", myFName);
                    session.setAttribute("user_id", String.valueOf(newID));
                    String redirectURL = "http://localhost:8080/Rentle";
                    response.sendRedirect(redirectURL);
                }
            
            }
            stmt.close();
            con.close();
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage());
        }
    %>

</body>
</html>