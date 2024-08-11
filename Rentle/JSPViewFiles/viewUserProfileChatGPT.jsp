<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject, java.util.Collections"%>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentUserId = request.getParameter("currentUserId");
        String inputText = request.getParameter("inputText");

        String query = "SELECT profile_picture FROM user WHERE user_id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, currentUserId);
        rs = pstmt.executeQuery();
        String profilePic = "";
        if (rs.next()) {
            profilePic = rs.getString(1);
        }
%>
<div class="chatbox_module">
    <div class="user_message"> <%=inputText%> </div>
    <img src="<%=profilePic%>" class="user_profile_pic"></div>
</div>
<%
    } catch(SQLException e) {
        out.println("Database error: " + e.getMessage());
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch(SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
