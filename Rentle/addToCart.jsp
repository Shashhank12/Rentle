<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentItemId = request.getParameter("currentItemId");
        String currentUserId = request.getParameter("currentUserId");
        String duration = request.getParameter("duration");
        String viewItemQuantity = request.getParameter("viewItemQuantity");
        String itemUserId = request.getParameter("itemUserId");
        String pricePerItem = request.getParameter("pricePerItem");
        
        String insertQuery = "INSERT INTO cart (UserID, ItemID, duration, quantity, UserRentID, price_per_item) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(insertQuery);
        pstmt.setString(1, currentUserId);
        pstmt.setString(2, currentItemId);
        pstmt.setString(3, duration);
        pstmt.setString(4, viewItemQuantity);
        pstmt.setString(5, itemUserId);
        pstmt.setString(6, pricePerItem);
        pstmt.executeUpdate();
        out.println("Item added to the cart.");

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
