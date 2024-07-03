<%@ page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <title>Sign In</title>
</head>
<body>
    <div id="main">
        <div id="leftwrap" class="main-child">
            <h1>Welcome Back!</h1>
            <p>Sign in to continue browsing an endless catalog of items or to list your items for rent.</p>
        </div>
        <div id="rightwrap" class="main-child">
            <form action="/home.jsp" id="sign-up-form">
                <label for="username" id="username-label">Username:</label>
                <input type="text" name="username" class="formtext" id="username">
                
                <label for="password" id="password-label">Password:</label>
                <input type="password" name="password" class="formtext" id="password">

                <input type="submit" value="Sign In" id="sign-in-submit">
            </form>

            <a href="/sign-up.jsp" id="tosignup"><button> Don't have an account?</button></a>
        </div>
    </div>
</body>
</html>