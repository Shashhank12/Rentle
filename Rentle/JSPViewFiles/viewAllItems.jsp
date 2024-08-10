<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
Connection con= null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs= null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

    String query1 = "SELECT item_id, name, location FROM items";
    stmt = con.createStatement();
    rs = stmt.executeQuery(query1);

    while (rs.next()) {
        String itemID = rs.getString(1);
        String name = rs.getString(2);
        String location = rs.getString(3);

        String photo = "", features = "", prices = "", category = "";

        String query2 = "SELECT photo FROM contains JOIN (photos) ON (contains.PhotoID = photos.photo_id) WHERE ItemID = ? LIMIT 1";
        pstmt = con.prepareStatement(query2);
        pstmt.setString(1, itemID);
        ResultSet rs1 = pstmt.executeQuery();
        if (rs1.next()) {
            photo = rs1.getString(1);
        }

        String query3 = "SELECT features_name FROM features JOIN alsohave USING (features_id) WHERE item_id = ? LIMIT 1";
        pstmt = con.prepareStatement(query3);
        pstmt.setString(1, itemID);
        rs1 = pstmt.executeQuery();
        if (rs1.next()) {
            features = rs1.getString(1);
        }

        String query4 = "SELECT LEAST(COALESCE(price_per_hour, 999999999), COALESCE(price_per_day, 999999999), COALESCE(price_per_week, 999999999), COALESCE(price_per_month, 999999999)) FROM prices JOIN rentsfor ON (rentsfor.PricesID = prices.prices_id) WHERE ItemID = ?";
        pstmt = con.prepareStatement(query4);
        pstmt.setString(1, itemID);
        rs1 = pstmt.executeQuery();
        if (rs1.next()) {
            prices = rs1.getString(1);
        }

        String query5 = "SELECT category_name FROM has JOIN category ON (category.category_id = has.CategoryID) WHERE ItemID = ?";
        pstmt = con.prepareStatement(query5);
        pstmt.setString(1, itemID);
        rs1 = pstmt.executeQuery();
        if (rs1.next()) {
            category = rs1.getString(1);
        }
%>
<div class="grid_item">
    <img src="<%=photo%>" onerror="this.src='images/profilepicgroup.png';" alt="" class="item_image">
    <div class="grid_item_module_1">
        <div class="grid_item_module_2">
            <div class="item_name"> <%= name %> </div>
            <div class="item_module_1">
                <div class="item_category"> <%=category%> - </div>
                <div class="item_feature"> <%=features%> </div>
            </div>
            <div class="item_location"> <%=location%> </div>
        </div>
        <div class="item_price"> $<%=prices%> </div>
    </div>
</div>
    
<%  }
} catch (SQLException e) {
    e.printStackTrace(); 
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace(); 
    }
}
%>