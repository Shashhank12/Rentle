<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<%
    Connection con = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentUserId = request.getParameter("currentUserId");
        String renterUserId = request.getParameter("renterUserId");
        String starRating = request.getParameter("starRating");
        String criteria = request.getParameter("criteria");
        String description = request.getParameter("description");

        String query = "SELECT MAX(review_id) FROM reviews";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);
        
        int review_id = 1;
        if (rs.next()) {
            review_id = rs.getInt(1) + 1;
        }
        
        String query1 = "INSERT INTO reviews (review_id, stars, description, criteria) VALUES (?, ?, ?, ?)";
        pstmt = con.prepareStatement(query1);
        pstmt.setInt(1, review_id);
        pstmt.setString(2, starRating);
        pstmt.setString(3, description);
        pstmt.setString(4, criteria);
        pstmt.executeUpdate();

        String query2 = "INSERT INTO receives (UserID, ReviewID) VALUES (?, ?)";
        pstmt = con.prepareStatement(query2);
        pstmt.setString(1, renterUserId);
        pstmt.setInt(2, review_id);
        pstmt.executeUpdate();

        String query3 = "INSERT INTO writes (UserID, ReviewID) VALUES (?, ?)";
        pstmt = con.prepareStatement(query3);
        pstmt.setString(1, currentUserId);
        pstmt.setInt(2, review_id);
        pstmt.executeUpdate();

        out.println("Reviews added");

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
