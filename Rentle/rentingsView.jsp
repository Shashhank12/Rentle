<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    try {

        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false&maxReconnects=10","root", "Hello1234!");

        String userId = request.getParameter("currentUserId");

        String query1 = "SELECT ItemID FROM cart WHERE UserID = ?";
        PreparedStatement pstmt = con.prepareStatement(query1);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String photoLink = "", name = "", category = "", location = "", rentDate = "", rentExpiration = "", total = "", quantity = "", features = "";

            String query2 = "SELECT photo FROM photos JOIN contains ON (photos.photo_id = contains.PhotoID) WHERE ItemID = ? ORDER BY PhotoID LIMIT 1";
            pstmt = con.prepareStatement(query2);
            pstmt.setString(1, rs.getString(1));
            ResultSet rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                photoLink = rs1.getString(1);
            }

            String query3 = "SELECT category_name FROM category JOIN has ON (has.CategoryID = category.category_id) WHERE ItemID = ?";
            pstmt = con.prepareStatement(query3);
            pstmt.setString(1, rs.getString(1));
            rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                category = rs1.getString(1);
            }
            
            String query4 = "SELECT features_name FROM alsohave JOIN (features) USING (features_id) WHERE item_id = ?";
            pstmt = con.prepareStatement(query4);
            pstmt.setString(1, rs.getString(1));
            rs1 = pstmt.executeQuery();
            while (rs1.next()) {
                features += rs1.getString(1) + "- ";
            }

            String query5 = "SELECT name, location FROM items WHERE item_id = ?";
            pstmt = con.prepareStatement(query5);
            pstmt.setString(1, rs.getString(1));
            rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                name = rs1.getString(1);
                location = rs1.getString(2);
            }

            String query6 = "SELECT rentdate, rentexpiration, total, quantity FROM rent_history JOIN saves ON (rent_history.history_id = saves.RentHistoryID) WHERE ItemID = ? AND UserID = ?";
            pstmt = con.prepareStatement(query6);
            pstmt.setString(1, rs.getString(1));
            pstmt.setString(2, userId);
            rs1 = pstmt.executeQuery();
            while (rs1.next()) {
                rentDate = rs1.getString(1);
                rentExpiration = rs1.getString(2);
                total = rs1.getString(3);
                quantity = rs1.getString(4);
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            LocalDateTime rentCreatedDate = LocalDateTime.parse(rentDate, formatter);
            LocalDateTime rentExpirationDate = LocalDateTime.parse(rentExpiration, formatter);
            LocalDateTime currentDate = LocalDateTime.now();

            long duration = Duration.between(rentExpirationDate, rentCreatedDate).getSeconds(); 
            if (rentExpirationDate.isBefore(currentDate)) { %>
<div id="your_rentings_past_grid_container">
    <div class="your_rentings_past_grid_item">  
        <img src="<%=photoLink%>" onerror="this.src='images/profilepicgroup.png';" alt = "" class="your_rentings_past_grid_item_image">
        <div class="your_rentings_past_module">
            <div class="your_rentings_past_grid_item_title"> <%=name%> </div>
            <div class="your_rentings_past_category_module">
                <div class="your_rentings_past_grid_item_category"> Category: </div>
                <div class="your_rentings_past_grid_item_category_name"> <%=category%> </div>
            </div>
            <div class="your_rentings_past_features_module">
                <div class="your_rentings_past_grid_item_features"> Features: </div>
                <div class="your_rentings_past_grid_item_features_name"> <%=features%> </div>
            </div>
            <div class="your_rentings_past_location_module">
                <div class="your_rentings_past_grid_item_location"> Location: </div>
                <div class="your_rentings_past_grid_item_location_name"> <%=location%> </div>
            </div>
            <div class="your_rentings_past_date_module">
                <div class="your_rentings_past_grid_item_date"> Returned Date: </div>
                <div class="your_rentings_past_grid_item_date_name"> <%=rentExpiration%> </div>
            </div>
            <div class="your_rentings_past_duration_module">
                <div class="your_rentings_past_grid_item_duration"> Quantity: </div>
                <div class="your_rentings_past_grid_item_duration_name"> <%=quantity%> </div>
            </div>
            <div class="your_rentings_past_price_module">
                <div class="your_rentings_past_grid_item_price"> Price: </div>
                <div class="your_rentings_past_grid_item_price_name"> $<%=total%> </div>
            </div>
        </div>
    </div>
</div>              
            <% } 
            else { %>
<div id="your_rentings_current_grid_container">
    <div class="your_rentings_current_grid_item"> 
        <img src="<%=photoLink%>" onerror="this.src='images/profilepicgroup.png';" alt = "" class="your_rentings_current_grid_item_image">
        <div class="your_rentings_current_module">
            <div class="your_rentings_current_grid_item_title"> <%=name%> </div>
            <div class="your_rentings_current_category_module">
                <div class="your_rentings_current_grid_item_category"> Category: </div>
                <div class="your_rentings_current_grid_item_category_name"> <%=category%> </div>
            </div>
            <div class="your_rentings_current_features_module">
                <div class="your_rentings_current_grid_item_features"> Features: </div>
                <div class="your_rentings_current_grid_item_features_name"> <%=features%> </div>
            </div>
            <div class="your_rentings_current_location_module">
                <div class="your_rentings_current_grid_item_location"> Location: </div>
                <div class="your_rentings_current_grid_item_location_name"> <%=location%> </div>
            </div>
            <div class="your_rentings_current_date_module">
                <div class="your_rentings_current_grid_item_date"> Checkout Date: </div>
                <div class="your_rentings_current_grid_item_date_name"> <%=rentDate%> </div>
            </div>
            <div class="your_rentings_current_duration_module">
                <div class="your_rentings_current_grid_item_duration"> Duration: </div>
                <div class="your_rentings_current_grid_item_duration_name"> <%=duration%> </div>
            </div>
            <div class="your_rentings_current_quantity_module">
                <div class="your_rentings_current_grid_item_quantity"> Quantity: </div>
                <div class="your_rentings_current_grid_item_quantity_name"> <%=quantity%> </div>
            </div>
            <div class="your_rentings_current_price_module">
                <div class="your_rentings_current_grid_item_price"> Price: </div>
                <div class="your_rentings_current_grid_item_price_name"> $<%=total%> </div>
            </div>
        </div>
            <div class="your_rentings_current_time_remaining_module">
            <div class="your_rentings_current_grid_item_time_remaining"> Time remaining </div>
            <div class="your_rentings_current_grid_item_time_remaining_name"><%=duration%></div>
        </div>
    </div>
</div>              
            <%}
        }
    } catch(SQLException e) {
        out.println("SQL Exception: " + e);
    }
%>