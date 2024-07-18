<%@ page import="java.sql.*"%>
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
        String password = "PASSWORD"; //enter your password
    %>
    <title>Sign In</title>
</head>
<body>
    <div id="main">
        <div id="leftwrap" class="main-child">
            <h1>Welcome Back!</h1>
            <p>Sign in to continue browsing an endless catalog of items or to list your items for rent.</p>
        </div>
        <div id="rightwrap" class="main-child">
            <form id="sign-up-form">
                <label for="email" id="email-label">Email:</label>
                <input type="text" name="email" class="formtext" id="email">
                
                <%
                    String myEmail = (String)request.getParameter("email");
                    Boolean emailInvalid = false;
                    if (request.getParameter("submit") != null) {
                        try {
                            java.sql.Connection con;
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RentalProj?autoReconnect=true&useSSL=false",user, password);

                            Statement stmt = con.createStatement();

                            String emailQuery = String.format("SELECT COUNT(email) FROM user WHERE email = '%s';", myEmail);
                            ResultSet rs = stmt.executeQuery(emailQuery);
                            rs.next();
                            if (rs.getInt(1) == 0) {
                                emailInvalid = true;
                                %>
                                <p id="email-error" style="color: red;">No account with this email</p>
                                <%
                            }
                            
                            stmt.close();
                            con.close();
                        } catch(SQLException e) {
                            out.println("SQLException caught: " + e.getMessage());
                        }
                    }
                %>

                <label for="password" id="password-label">Password:</label>
                <input type="password" name="password" class="formtext" id="password">
                <%
                    String myPassword = (String)request.getParameter("password");
                    if (request.getParameter("submit") != null) {
                        try {
                            java.sql.Connection con;
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

                            Statement stmt = con.createStatement();

                            String passwordQuery = String.format("SELECT user_id FROM user WHERE email='%s' AND password='%s' ORDER BY user_id DESC;", myEmail, myPassword);
                            out.println(passwordQuery);
                            ResultSet rs = stmt.executeQuery(passwordQuery);
                            rs.next();

                            if (rs.getInt("user_id") > 0) {
                                String userID = String.valueOf(rs.getInt("user_id"));
                                session.setAttribute("userID", userID);
                                rs.close();
                                String redirectURL = "http://localhost:8080/home.jsp";
                                response.sendRedirect(redirectURL);
                            } else {
                            %>
                                <p id="password-error" style="color: red;">Password does not match</p>
                            <%
                            }
                            rs.close();
                            stmt.close();
                            con.close();
                        } catch(SQLException e) {
                            out.println("SQLException caught: " + e.getMessage());
                        }
                    }
                %>

                <input type="submit" value="Sign In" id="sign-in-submit" name="submit">
            </form>
            <a href="/sign-up.jsp" id="tosignup"><button> Don't have an account?</button></a>
        </div>
    </div>

</body>
</html>