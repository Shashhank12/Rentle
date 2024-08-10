<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false","root", "Hello1234!");

        String itemUserId = request.getParameter("itemUserId");
        String currentUserId = request.getParameter("currentUserId");

        String query1 = "SELECT * FROM friends WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
        PreparedStatement pstmt = con.prepareStatement(query1);
        pstmt.setString(1, itemUserId);
        pstmt.setString(2, currentUserId);
        pstmt.setString(3, currentUserId);
        pstmt.setString(4, itemUserId);
        ResultSet rs = pstmt.executeQuery();

        String decide = "";

        if (rs.next()) {
            String user1 = rs.getString(1);
            String user2 = rs.getString(2);
            String status = rs.getString(3);
            if (user2 == currentUserId && user1 == itemUserId) {
                String query3 = "UPDATE friends SET status = 1 WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
                PreparedStatement pstmt3 = con.prepareStatement(query3);
                pstmt3.setString(1, itemUserId);
                pstmt3.setString(2, currentUserId);
                pstmt3.setString(3, currentUserId);
                pstmt3.setString(4, itemUserId);
                pstmt3.executeUpdate();
                pstmt3.close();
                decide = "Friends";
            }
            else {
                String query4 = "DELETE FROM friends WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
                PreparedStatement pstmt4 = con.prepareStatement(query4);
                pstmt4.setString(1, itemUserId);
                pstmt4.setString(2, currentUserId);
                pstmt4.setString(3, currentUserId);
                pstmt4.setString(4, itemUserId);
                pstmt4.executeUpdate();
                pstmt4.close();
                decide = "Cancelled";
            }
            
        } else {
            String query2 = "INSERT INTO friends (FriendUserID1, FriendUserID2, status) VALUES (?, ?, 0)";
            PreparedStatement pstmt2 = con.prepareStatement(query2);
            pstmt2.setString(1, currentUserId);
            pstmt2.setString(2, itemUserId);
            pstmt2.executeUpdate();
            pstmt2.close();
            decide = "Pending";
        }
        out.print(decide);
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException: " + e);
    }
%>