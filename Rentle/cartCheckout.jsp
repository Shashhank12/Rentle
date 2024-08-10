<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Connection con = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentUserId = request.getParameter("currentUserId");

        ArrayList<String> name = new ArrayList<>();
        ArrayList<String> duration = new ArrayList<>();
        ArrayList<String> quantity = new ArrayList<>();
        ArrayList<String> item = new ArrayList<>();
        ArrayList<String> rentUserID = new ArrayList<>();
        ArrayList<String> pricePerItem = new ArrayList<>();


        String query = "SELECT item_id, name, duration, cart.quantity, UserRentID, price_per_item FROM cart JOIN items ON (cart.ItemId = items.item_id) WHERE UserID = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, currentUserId);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            item.add(rs.getString(1));
            name.add(rs.getString(2));
            duration.add(rs.getString(3));
            quantity.add(rs.getString(4));
            rentUserID.add(rs.getString(5));
            pricePerItem.add(rs.getString(6));
        }
        
        int history_id = 1;
        for (int i = 0; i < item.size(); i++) {
            String query4 = "SELECT MAX(history_id) FROM rent_history";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query4);
            if (rs.next()) {
                history_id = rs.getInt(1) + 1;
            }
            String query5 = "INSERT INTO rent_history (history_id, rentdate, ItemID, rentexpiration, rentprice, quantity) VALUES (?, NOW(), ?, DATE_ADD(NOW(), INTERVAL ? SECOND), ?, ?)";
            pstmt = con.prepareStatement(query5);
            pstmt.setInt(1, history_id);
            pstmt.setString(2, item.get(i));
            pstmt.setString(3, duration.get(i));
            pstmt.setString(4, pricePerItem.get(i));
            pstmt.setString(5, quantity.get(i));
            pstmt.executeUpdate();

            String query6 = "INSERT INTO saves (UserID, RentHistoryID) VALUES (?, ?)";
            pstmt = con.prepareStatement(query6);
            pstmt.setString(1, currentUserId);
            pstmt.setInt(2, history_id);
            pstmt.executeUpdate();

            String query7 = "INSERT INTO holds (UserID, RentHistoryID) VALUES (?, ?)";
            pstmt = con.prepareStatement(query7);
            pstmt.setString(1, currentUserId);
            pstmt.setString(2, rentUserID.get(i));
            pstmt.executeUpdate();
        }

        String query8 = "DELETE FROM cart WHERE UserID = ?";
        pstmt = con.prepareStatement(query8);
        pstmt.setString(1, currentUserId);
        pstmt.executeUpdate();

        session.setAttribute("cart_total", "0");

    } catch(SQLException e) {
        out.println("Database error: " + e.getMessage());
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
            if (rs != null) rs.close();
        } catch(SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
