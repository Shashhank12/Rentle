<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject, java.util.Collections"%>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

    String userId = request.getParameter("userId");
    String groupUsersParam = request.getParameter("groupUsers");

    // Check if the parameter is null or empty
    if (groupUsersParam == null || groupUsersParam.trim().isEmpty()) {
        // Handle the case where no group users are provided
        groupUsersParam = ""; // Or set it to an empty string to avoid splitting issues
    }

    // Split the parameter into an array of user IDs
    String[] groupUsers = groupUsersParam.split(",");

    String inputVal = request.getParameter("inputVal");
    if (inputVal == null || inputVal.trim().isEmpty()) {
        inputVal = "%"; // This will match any string in SQL LIKE
    } else {
        inputVal = inputVal.replaceAll("\\s+", "");
        inputVal = "%" + inputVal + "%";
    }

    String additionalText = "AND user_id NOT IN (";
    if (groupUsers.length == 0) {
        additionalText = "LIMIT 50";
    }
    else {
        if (groupUsers[0] != "") {
            for (int i = 0; i < groupUsers.length; i++) {
                additionalText += "?, ";
            }
            additionalText = additionalText.trim();
            additionalText = additionalText.substring(0, additionalText.length() - 1);
            additionalText += ") LIMIT 50";
        }
        else {
            additionalText = "LIMIT 50";
        }
    }
    

    String query5 = "SELECT user_id, profile_picture, first_name, last_name " +
                     "FROM (" +
                     "    SELECT DISTINCT u.user_id, u.profile_picture, u.first_name, u.last_name " +
                     "    FROM rentle.friends f " +
                     "    JOIN rentle.user u " +
                     "        ON (f.FriendUserID1 = ? AND u.user_id = f.FriendUserID2) " +
                     "        OR (f.FriendUserID2 = ? AND u.user_id = f.FriendUserID1) " +
                     "    UNION " +
                     "    SELECT u.user_id, u.profile_picture, u.first_name, u.last_name " +
                     "    FROM rentle.user u " +
                     "    WHERE u.user_id != ? " +
                     "      AND u.user_id NOT IN (" +
                     "        SELECT DISTINCT CASE " +
                     "            WHEN f.FriendUserID1 = ? THEN f.FriendUserID2 " +
                     "            ELSE f.FriendUserID1 " +
                     "        END " +
                     "        FROM rentle.friends f " +
                     "        WHERE f.FriendUserID1 = ? OR f.FriendUserID2 = ? " +
                     "    )" +
                     ") AS combined_results " +
                     "WHERE CONCAT(first_name, last_name) LIKE ? " +
                     additionalText;

    PreparedStatement pstmt = conn.prepareStatement(query5);
    pstmt.setString(1, userId);
    pstmt.setString(2, userId);
    pstmt.setString(3, userId);
    pstmt.setString(4, userId);
    pstmt.setString(5, userId);
    pstmt.setString(6, userId);
    pstmt.setString(7, inputVal);
    for (int i = 0; i < groupUsers.length; i++) {
        pstmt.setString(8 + i, groupUsers[i]);
    }
    ResultSet rs = pstmt.executeQuery();

    while (rs.next()) {
        String addUserId = rs.getString(1);
        String addProfilePicture = rs.getString(2);
        String addfirstName = rs.getString(3);
        String addLastName = rs.getString(4);
        String gridItemName = addfirstName + " " + addLastName;
%>
    <div class="your_messages_add_group_chat_grid_item">
        <div class="your_messages_add_group_chat_user_id" style="display:none"> <%=addUserId%></div>
        <img src="<%=addProfilePicture%>" onerror="this.src='images/profilepicgroup.png';" class="your_messages_add_group_chat_grid_item_profile_picture">
        <div class="your_messages_add_group_chat_grid_item_username"> <%=gridItemName%> </div>
    </div>
<%
    }

} catch (SQLException e) {
    out.println("SQLException: " + e.getMessage()); 
}
%>