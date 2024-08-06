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
        rs.close();
        pstmt.close();

        // Output HTML
%>
        <div class="view_item_photo_module">
            <div class="view_item_photo"></div>
            <div id="photo_back_button"></div>
            <div id="photo_front_button"></div>
        </div>
        <div class="view_item_information_module">
            <div class="view_item_title"> <strong><%=title%> </strong></div>
            <div class="view_item_prices"><%=price%></div>
            <div class="view_item_listed_date_module">
                <div class="view_item_listed_date_name"> <strong>Listed date:</strong> </div>
                <div class="view_item_listed_date"> <%=postedDate%>, </div>
                <div class="view_item_listed_date_count"> 7 days ago </div>
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
