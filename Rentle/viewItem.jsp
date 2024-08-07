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

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String currentItemId = request.getParameter("currentItemId");
        String currentUserId = request.getParameter("currentUserId");

        if (currentItemId == null || currentItemId.isEmpty()) {
            out.println("Invalid item ID.");
            return;
        }

        // Query to get item details
        String query = "SELECT * FROM items WHERE item_id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, currentItemId);
        rs = pstmt.executeQuery();

        String title = "";
        String condition = "";
        String description = "";
        String location = "";
        String postedDate = "";
        String price = "";
        String category = "";
        String features = "";
        String name = "";
        String profilePic = "";

        if (rs.next()) {
            title = rs.getString(2); // Assuming column names are used here
            condition = rs.getString(3);
            description = rs.getString(4);
            location = rs.getString(5);
            postedDate = rs.getString(9);
        }

        // Define the formatter for the input date string
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        // Parse the input string to a LocalDateTime object
        LocalDateTime dateTime = LocalDateTime.parse(postedDate, inputFormatter);
        
        // Calculate the duration between the input date and the current date
        LocalDateTime currentDateTime = LocalDateTime.now();
        Duration duration = Duration.between(dateTime, currentDateTime);
        long totalSeconds = duration.getSeconds();
        
        // Determine the appropriate time unit and format
        String timeCount;
        
        if (totalSeconds < 60) {
            timeCount = totalSeconds + " seconds ago";
        } else if (totalSeconds < 3600) {
            long minutes = totalSeconds / 60;
            timeCount = minutes + " minutes ago";
        } else if (totalSeconds < 86400) {
            long hours = totalSeconds / 3600;
            timeCount = hours + " hours ago";
        } else if (totalSeconds < 2592000) { // Approximately 30 days
            long days = totalSeconds / 86400;
            timeCount = days + " days ago";
        } else if (totalSeconds < 31536000) { // Approximately 365 days
            long months = totalSeconds / 2592000; // 30 days approx.
            timeCount = months + " months ago";
        } else {
            long years = totalSeconds / 31536000; // 365 days approx.
            timeCount = years + " years ago";
        }
        
        // Format the date for display
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MMMM d'th', yyyy", Locale.ENGLISH);
        postedDate = outputFormatter.format(dateTime);
        
        // Adjust the suffix
        int day = dateTime.getDayOfMonth();
        String suffix;
        if (day >= 11 && day <= 13) {
            suffix = "th";
        } else {
            switch (day % 10) {
                case 1: suffix = "st"; break;
                case 2: suffix = "nd"; break;
                case 3: suffix = "rd"; break;
                default: suffix = "th"; break;
            }
        }
        postedDate = postedDate.replace("th", suffix);

        rs.close();
        pstmt.close();

        // Query to get pricing details
        String query2 = "SELECT price_per_hour, price_per_day, price_per_week, price_per_month FROM prices JOIN rentsfor ON rentsfor.PricesID = prices.prices_id WHERE rentsfor.ItemID = ?";
        pstmt = con.prepareStatement(query2);
        pstmt.setString(1, currentItemId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String priceHour = rs.getString(1);
            String priceDay = rs.getString(2);
            String priceWeek = rs.getString(3);
            String priceMonth = rs.getString(4);

            if (priceHour != null) {
                price += "$" + priceHour + "/hour - ";
            }
            if (priceDay != null) {
                price += "$" + priceDay + "/day - ";
            }
            if (priceWeek != null) {
                price += "$" + priceWeek + "/week - ";
            }
            if (priceMonth != null) {
                price += "$" + priceMonth + "/month - ";
            }
        }
        price = price.trim();
        price = price.substring(0, price.length() - 1);
        rs.close();
        pstmt.close();

        // Query to get category
        String query3 = "SELECT category_name FROM has JOIN category ON (category.category_id = has.CategoryID) WHERE ItemID = ?";
        pstmt = con.prepareStatement(query3);
        pstmt.setString(1, currentItemId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            category = rs.getString(1);
        }
        rs.close();
        pstmt.close();

        // Query to get features
        String query4 = "SELECT features_name FROM consistsof JOIN features ON consistsof.FeaturesID = features.features_id WHERE CategoryID = ?";
        pstmt = con.prepareStatement(query4);
        pstmt.setString(1, category);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String feature = rs.getString(1);
            if (feature != null && !feature.isEmpty()) {
                features += feature + "- ";
            }
        }
        rs.close();
        pstmt.close();

        // Query to get user profile
        String query5 = "SELECT first_name, last_name, profile_picture FROM user WHERE user_id = (SELECT UserID FROM rent WHERE ItemID = ?)";
        pstmt = con.prepareStatement(query5);
        pstmt.setString(1, currentItemId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString(1) + " " + rs.getString(2);
            profilePic = rs.getString(3);
        }

        String query6 = "SELECT photo FROM contains JOIN photos ON (contains.PhotoID = photos.photo_id) WHERE ItemID = ?";
        pstmt = con.prepareStatement(query6);
        pstmt.setString(1, currentItemId);
        rs = pstmt.executeQuery();

        ArrayList<String> photoArray = new ArrayList<>();

        while (rs.next()) {
            photoArray.add(rs.getString(1));
        }

        JSONArray jsonArray = new JSONArray(photoArray);
        String jsonArrayString = jsonArray.toString();

        rs.close();
        pstmt.close();

        // Output HTML
%>
        <div class="view_item_information_module">
            <div class="view_item_store_information" data-photos='<%=jsonArrayString%>' style="display:none"></div>
            <div class="view_item_title"> <strong><%=title%> </strong></div>
            <div class="view_item_prices"><%=price%></div>
            <div class="view_item_listed_date_module">
                <div class="view_item_listed_date_name"> <strong>Listed date:</strong> </div>
                <div class="view_item_listed_date"> <%=postedDate%> - </div>
                <div class="view_item_listed_date_count"> <%=timeCount%> </div>
            </div>
            <div class="view_item_location_module">
                <div class="view_item_location_name"> <strong>Location:</strong></div>
                <div class="view_item_location"> <%=location%> </div>
            </div>
            <div class="view_item_category_module">
                <div class="view_item_category_name"> <strong>Category:</strong> </div>
                <div class="view_item_category"> <%=category%> </div>
            </div>
            <div class="view_item_features_module">
                <div class="view_item_features_name"> <strong>Features:</strong></div>
                <div class="view_item_features"> <%=features%> </div> 
            </div>
            <div class="view_item_description_module">
                <div class="view_item_description_name"> <strong>Description</strong></div>
                <div class="view_item_description"><%=description%></div>
                <div class="view_item_description_see_more"> See more </div>
            </div>
            <div class="view_item_user_module">
                <img src="<%=profilePic%>" class="view_item_user_profile_picture">
                <div class="view_item_view_user_profile"> SEE INFO </div>
                <div class="view_item_user_module_1">
                    <div class="view_item_user_name"><%=name%></div>
                    <div class="view_item_user_module_2">
                        <div class="view_item_reviews"> 4.5 </div>
                        <div class="view_item_reviews_count"> - 144 reviews </div>
                    </div>
                </div>
            </div>
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
