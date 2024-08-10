<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String userId = request.getParameter("currentUserId");

        String getCartQuery = "SELECT name, duration, cart.quantity, price_per_item FROM cart JOIN items ON (cart.ItemID = items.item_id) WHERE UserID = ?";
        PreparedStatement pstmt = con.prepareStatement(getCartQuery);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();
        String name = "", duration = "", quantity = "", pricePerItem = "", total = "";
        while (rs.next()) { 
            name = rs.getString(1);
            duration = rs.getString(2);
            quantity = rs.getString(3);
            pricePerItem = rs.getString(4);
            double pricePerItemValue = Double.parseDouble(pricePerItem);
        %>
        <div class="cart_item">
            <div class="cart_item_module">
                <div class="cart_item_title"><%=name%></div>
                <div class="cart_item_module_2">
                    <div class="cart_item_duration_icon"></div>
                    <div class="cart_item_duration"><%=duration%></div>
                </div>
            </div>
            <div class="cart_item_quantity">x<%=quantity%></div>
            <div class="cart_item_price">$<%=String.format("%.1f", pricePerItemValue)%></div>
        </div>
        <% }

        String getCartQuery2 = "SELECT SUM(price_per_item) FROM cart JOIN items ON (cart.ItemId = items.item_id) WHERE UserID = ?";
        pstmt = con.prepareStatement(getCartQuery2);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            total = rs.getString(1);
        }
        double totalValue = (total != null) ? Double.parseDouble(total) : 0.0;
        String formattedCartTotal = String.format("%.1f", totalValue);
        session.setAttribute("cart_total", formattedCartTotal);
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        e.printStackTrace(); 
    }
%>