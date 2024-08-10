<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        ArrayList<String> profilePics = new ArrayList<>();
        ArrayList<String> names = new ArrayList<>();

        String inputVal = request.getParameter("inputVal");
        if (inputVal == null || inputVal.trim().isEmpty()) {
            inputVal = "%"; // This will match any string in SQL LIKE
        } else {
            inputVal = inputVal.replaceAll("\\s+", "");
            inputVal = "%" + inputVal + "%";
        }

        String query = "SELECT profile_picture, first_name, last_name FROM rentle.user WHERE CONCAT(first_name, last_name) LIKE ? LIMIT 1000";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, inputVal);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) { 
            profilePics.add(rs.getString(1));
            names.add(rs.getString(2) + " " + rs.getString(3));
        }

        for (int i = 0; i < names.size(); i++) {
            String query2 = "SELECT COUNT(*) FROM friends WHERE FriendUserID1 = ? OR FriendUserID2 = ?";
            pstmt = con.prepareStatement(query2);
            pstmt.setInt(1, i);
            pstmt.setInt(2, i);
            rs = pstmt.executeQuery();
            if (rs.next()) {
%>
                <div class="friends_view_module_1_grid_item_all_people" value="<%=i + 1%>">
                    <img src="<%=profilePics.get(i)%>" onerror="this.src='images/profilepicgroup.png';" class="friends_view_module_1_grid_item_all_people_profile_picture">
                    <div class="friends_view_module_1_grid_item_all_people_1">
                        <div class="friends_view_module_1_grid_item_all_people_name"> <%=names.get(i)%> </div>
                        <div class="friends_view_module_1_grid_item_all_people_friends_count"> <%=rs.getString(1)%> friends </div>
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