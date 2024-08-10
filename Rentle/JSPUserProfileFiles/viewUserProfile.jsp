<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false","root", "Hello1234!");

        String itemUserId = request.getParameter("itemUserId");

        Statement stmt = con.createStatement();

        String getUserInfoQuery = "SELECT * FROM rentle.user WHERE user_id = ?";
        PreparedStatement pstmt = con.prepareStatement(getUserInfoQuery);
        pstmt.setString(1, itemUserId); // Safely set the parameter
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String fullname = rs.getString("first_name") + " " + rs.getString("last_name");
            String email = rs.getString("email");
            String number = rs.getString("phone_number");
            String pfp = rs.getString("profile_picture");
            String date = LocalDateTime.parse(rs.getString("creation_date").replace(" ","T")).format(DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM));
%>
<div class="view_user_profile_1">
    <img src="<%=pfp%>" onerror="this.src='images/profilepicgroup.png';" alt="" class="profile_picture">
    <div class="view_user_profile_2_asterisk">
        <div class="view_user_profile_2">
            <div class="view_user_profile_3">
                <div class="email_icon"></div>
                <div class="phone_number_icon"></div>
            </div>
            <div class="view_user_profile_4">
                <div class="email"><%=email%></div>
                <div class="phone_number"><%=number%></div>
            </div>
        </div>
        <div class="view_user_profile_module">
            <div class="view_user_profile_module_add_friend"></div>
            <div class="view_user_profile_module_message">Message</div>
            <div class="view_user_profile_module_see_rentals">Rentals</div>
        </div>
    </div>
</div>
<div class="user_full_name"><%=fullname%></div>
<div class="member_date"> Member since <%=date%></div>
<%
        }
        String getUserInfoQuery2 = "SELECT city, state FROM islocatedat JOIN address ON (islocatedat.AddressID = address.address_id) WHERE UserID = ?";
        pstmt = con.prepareStatement(getUserInfoQuery2);
        pstmt.setString(1, itemUserId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String city = rs.getString(1);
            String state = rs.getString(2);
%>
<div class="current_location"> Currently at <%=city%>, <%=state%> </div>
<%
        }
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException: " + e);
    }
%>