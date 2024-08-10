<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.temporal.TemporalAmount" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%!
    public String formatDateTime(String dateStr) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(dateStr, inputFormatter);

        String month = dateTime.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
        int day = dateTime.getDayOfMonth();
        String daySuffix = getDaySuffix(day);
        int year = dateTime.getYear();

        int hour = dateTime.getHour();
        int minute = dateTime.getMinute();
        String time;
        if (hour >= 12) {
            time = String.format("%02d:%02d pm", hour, minute);
        } else {
            if (hour == 0) {
                hour = 12;
            }
            time = String.format("%02d:%02d am", hour, minute);
        }

        return String.format("%s %d%s, %d - %s", month, day, daySuffix, year, time);
    }

    private String getDaySuffix(int day) {
        if (day >= 11 && day <= 13) {
            return "th";
        }
        switch (day % 10) {
            case 1:
                return "st";
            case 2:
                return "nd";
            case 3:
                return "rd";
            default:
                return "th";
        }
    }
%>

<%
    try {

        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false&maxReconnects=10","root", "Hello1234!");

        String userId = request.getParameter("currentUserId");
        String itemUserId = "";

        String query1 = "SELECT ItemID FROM saves JOIN rent_history ON (saves.RentHistoryID = rent_history.history_id) WHERE UserID = ?";
        PreparedStatement pstmt = con.prepareStatement(query1);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String photoLink = "", name = "", category = "", location = "", rentDate = "", rentExpiration = "", rentPrice = "", quantity = "", features = "", userName = "", profile_picture = "", activeListing = "";

            String query2 = "SELECT photo FROM photos JOIN contains ON (photos.photo_id = contains.PhotoID) WHERE ItemID = ? ORDER BY PhotoID LIMIT 1";
            pstmt = con.prepareStatement(query2);
            pstmt.setString(1, rs.getString(1));
            ResultSet rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                photoLink = rs1.getString(1);
                photoLink = photoLink.replace("./Images/", "images/");
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

            String query6 = "SELECT rentdate, rentexpiration, rentprice, quantity FROM rent_history JOIN saves ON (rent_history.history_id = saves.RentHistoryID) WHERE ItemID = ? AND UserID = ?";
            pstmt = con.prepareStatement(query6);
            pstmt.setString(1, rs.getString(1));
            pstmt.setString(2, userId);
            rs1 = pstmt.executeQuery();
            while (rs1.next()) {
                rentDate = rs1.getString(1);
                rentExpiration = rs1.getString(2);
                rentPrice = rs1.getString(3);
                quantity = rs1.getString(4);
            }

            String query7 = "select user_id, first_name, last_name, profile_picture from user join rent ON (rent.UserID = user.user_id) WHERE ItemID = ?";
            pstmt = con.prepareStatement(query7);
            pstmt.setString(1, rs.getString(1));
            rs1 = pstmt.executeQuery();
            while (rs1.next()) {
                itemUserId = rs1.getString(1);
                userName = rs1.getString(2) + " " + rs1.getString(3);
                profile_picture = rs1.getString(4);
            }

            String query8 = "select count(*) from rent where ItemID = ?";
            pstmt = con.prepareStatement(query8);
            pstmt.setString(1, rs.getString(1));
            rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                activeListing = rs1.getString(1);
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            LocalDateTime rentCreatedDate = LocalDateTime.parse(rentDate, formatter);
            LocalDateTime rentExpirationDate = LocalDateTime.parse(rentExpiration, formatter);
            LocalDateTime currentDate = LocalDateTime.now();

            long duration = Duration.between(rentCreatedDate, rentExpirationDate).getSeconds(); 
            long timeRemaining = Duration.between(currentDate, rentExpirationDate).getSeconds();
            if (timeRemaining > 0) {
                continue;
            }

            double rentPriceValue = Double.parseDouble(rentPrice);
%>

    <div class="your_rentings_past_grid_item" value="<%=itemUserId%>">  
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
                <div class="your_rentings_past_grid_item_date_name"> <%=formatDateTime(rentExpiration)%> </div>
            </div>
            <div class="your_rentings_past_duration_module">
                <div class="your_rentings_past_grid_item_duration"> Quantity: </div>
                <div class="your_rentings_past_grid_item_duration_name"> <%=quantity%> </div>
            </div>
            <div class="your_rentings_past_price_module">
                <div class="your_rentings_past_grid_item_price"> Price: </div>
                <div class="your_rentings_past_grid_item_price_name"> $<%=String.format("%.2f", rentPriceValue)%> </div>
            </div>
        </div>
        <div class="your_rentings_past_user_profile_module">
            <div class="your_rentings_past_user_profile_module_1">
                <div class="your_rentings_past_user_info_active_listings"> <%=activeListing%> active listings </div>
                <div class="your_rentings_past_user_info_name"> <%=userName%> </div>
            </div>
            <img src="<%=profile_picture%>" onerror="this.src='images/profilepicgroup.png';" class="your_rentings_past_user_info_profile_picture">
        </div>
    </div>           
<%
        }
    } catch(SQLException e) {
        out.println("SQL Exception: " + e);
    }
%>