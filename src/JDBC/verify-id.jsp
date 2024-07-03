<%@ page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <title>Verify ID</title>
</head>
<body>
    <div id="main">
        <div id="leftwrap" class="main-child">
            <h1>Verify ID</h1>
            <p>Submit a photo of an approved ID format to get verified. You may opt out of this, however, verifying your ID improves credibility.</p>
        </div>
        <div id="rightwrap" class="main-child">
            <form action="/home.jsp" id="verify-id-form">
                <label for="id-type-dropdown">Choose ID Type:</label>
                <select name="id-type-dropdown" id="id-type-dropdown">
                    <option value="state-id">State ID</option>
                    <option value="drivers-license">Driver's License</option>
                    <option value="passport">Passport</option>
                </select>

                <label for="upload-img">Upload Image:</label>
                <input type="file" name="upload-img" id="upload-img" accept="image/*">

                <input type="submit" value="Finish Signing Up" id="sign-up-submit">
            </form>

            <a href="/home.jsp" id="tohome"><button>Verify Later</button></a>
        </div>
    </div>
</body>
</html>