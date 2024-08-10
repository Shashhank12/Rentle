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

        String fullname = "", email = "", number = "", pfp = "", date = "";

        if (rs.next()) {
            String fullname = rs.getString("first_name") + " " + rs.getString("last_name");
            String email = rs.getString("email");
            String number = rs.getString("phone_number");
            String pfp = rs.getString("profile_picture");
            String date = LocalDateTime.parse(rs.getString("creation_date").replace(" ","T")).format(DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM));
        }
%>
<div class="view_user_profile_1_friends_tab">
    <img src="<%=pfp%>" onerror="this.src='images/profilepicgroup.png';" alt="" class="profile_picture_friends_tab">
    <div class="view_user_profile_2_asterisk_friends_tab">
        <div class="view_user_profile_2_friends_tab">
            <div class="view_user_profile_3_friends_tab">
                <div class="email_icon_friends_tab"></div>
                <div class="phone_number_icon_friends_tab"></div>
            </div>
            <div class="view_user_profile_4_friends_tab">
                <div class="email_friends_tab"><%=email%></div>
                <div class="phone_number_friends_tab"><%=number%></div>
            </div>
        </div>
        <div class="view_user_profile_module_friends_tab">
<%
        

%>
            <div class="view_user_profile_module_add_friend_friends_tab"> Add friend </div>
            <div class="view_user_profile_module_message_friends_tab">Message</div>
            <div class="view_user_profile_module_see_rentals_friends_tab">Rentals</div>
        </div>
    </div>
</div>
<div class="user_full_name_friends_tab"><%=fullname%></div>
<div class="member_date_friends_tab"> Member since <%=date%></div>
<%
        String getUserInfoQuery2 = "SELECT city, state FROM islocatedat JOIN address ON (islocatedat.AddressID = address.address_id) WHERE UserID = ?";
        pstmt = con.prepareStatement(getUserInfoQuery2);
        pstmt.setString(1, itemUserId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String city = rs.getString(1);
            String state = rs.getString(2);
%>
<div class="current_location_friends_tab"> Currently at <%=city%>, <%=state%> </div>
<%
        }
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException: " + e);
    }
%>