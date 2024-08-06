<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "1Wins4All");

        String currentItemId = request.getParameter("currentItemId");
        String currentUserId = request.getParameter("currentUserId");
        String duration = request.getParameter("duration");
        String viewItemQuantity = request.getParameter("viewItemQuantity");
        
        String query = "INSERT INTO cart (UserID, ItemID, duration, quantity) VALUES (?, ?, ?, ?)";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, currentUserId);
        pstmt.setString(2, currentItemId);
        pstmt.setString(3, duration);
        pstmt.setString(4, viewItemQuantity);
        pstmt.executeUpdate();

    } catch(SQLException e) {
        out.println("Database error: " + e.getMessage());
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch(SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
