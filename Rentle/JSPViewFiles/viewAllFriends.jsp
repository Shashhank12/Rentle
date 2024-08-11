<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentUserId = request.getParameter("currentUserId");
        String inputVal = request.getParameter("inputVal");
        if (inputVal == null || inputVal.trim().isEmpty()) {
            inputVal = "%"; // This will match any string in SQL LIKE
        } else {
            inputVal = inputVal.replaceAll("\\s+", "");
            inputVal = "%" + inputVal + "%";
        }

        String query = "SELECT user_id, profile_picture, first_name, last_name FROM user JOIN (SELECT CASE WHEN FriendUserID1 = ? THEN FriendUserID2 WHEN FriendUserID2 = ? THEN FriendUserID1 END AS user_id FROM rentle.friends WHERE FriendUserID1 = ? OR FriendUserID2 = ?) AS a USING (user_id) WHERE CONCAT(first_name, last_name) LIKE ? LIMIT 1000";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, currentUserId);
        pstmt.setString(2, currentUserId);
        pstmt.setString(3, currentUserId);
        pstmt.setString(4, currentUserId);
        pstmt.setString(5, inputVal);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) { 
            String userId = rs.getString(1);
            String profilePic = rs.getString(2);
            String name = rs.getString(3) + " " + rs.getString(4);

            String query2 = "SELECT COUNT(*) FROM friends WHERE FriendUserID1 = ? OR FriendUserID2 = ? AND status = 1";
            pstmt = con.prepareStatement(query2);
            pstmt.setString(1, userId);
            pstmt.setString(2, userId);
            ResultSet rs1 = pstmt.executeQuery();
            if (rs1.next()) {
%>
<div class="friends_view_module_1_grid_item_friends_only" value="<%=userId%>">
    <img src="<%=profilePic%>" onerror="this.src='images/profilepicgroup.png';" class="friends_view_module_1_grid_item_friends_only_profile_picture">
    <div class="friends_view_module_1_grid_item_friends_only_1">
        <div class="friends_view_module_1_grid_item_friends_only_name"> <%=name%> </div>
        <div class="friends_view_module_1_grid_item_friends_only_friends_count"> <%=rs1.getString(1)%> friends </div>
    </div>
</div>
<%
            }

        }
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        e.printStackTrace(); 
    }
%>