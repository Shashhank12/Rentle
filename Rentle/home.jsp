<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>
<!DOCTYPE html>
<html>
<head>
    <title>Rentle - CS157A Project</title>
    <link rel="stylesheet" href="home.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

    <!-- Alicia (userId and db initialize), Scott (rest) -->
    <%
        String uname = (String)session.getAttribute("name");
        String userId = (String)session.getAttribute("user_id");

        String db = "rentle";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "Hello1234!"; //enter your password
        String currentGroupId = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
            String query3 = "SELECT group_id FROM rentle.group_chat WHERE FIND_IN_SET(?, group_users) > 0 ORDER BY group_id DESC LIMIT 1";
            PreparedStatement pstmt3 = conn.prepareStatement(query3);
            pstmt3.setString(1, userId);
            ResultSet rs3 = pstmt3.executeQuery();
            if (rs3.next()) {
                currentGroupId = rs3.getString("group_id");
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
    %>
    <script src="Homepage.js"></script>
    <script src="jquery-3.7.1.min.js"></script>
</head>
<body style="overflow-x: hidden;" onload="initMap()">

    <div id="user_id" style="display:none"> <%=userId%> </div>
    <div class="blur_background"></div>

    <!-- Shashhank Google Maps -->
    <div id="map"></div>
    <!-- TODO: ADD API KEY -->
    <script src="https://maps.googleapis.com/maps/api/js?key="></script>
    <script>
        var globalZoomLevel = 13;
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: globalZoomLevel,
            center: {lat: 37.337, lng: -121.881}
        });;
        function initMap() {
            // 5 miles
            var radius = 5 * 1609.34;
            var circle = new google.maps.Circle({
                strokeColor: '#FF0000',
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: '#FF0000',
                fillOpacity: 0.35,
                map: map,
                center: {lat: 37.337, lng: -121.881},
                radius: radius
            });

            var mainMarker = new google.maps.Marker({
                position: {lat: 37.337, lng: -121.881},
                map: map,
                title: 'Main Location', // Custom title for the special pin
                icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' // Custom icon for the special pin
            });
            
        }
    </script>
    
    <script>
        var geocoder = new google.maps.Geocoder();
        function addCenter(address) {
            globalZoomLevel = map.getZoom();
            // Create a map object and specify the DOM element for display.
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 37.337, lng: -122},
                // Keep same zoom level
                zoom: globalZoomLevel
            });
        
            // Create a Geocoder instance
            
            if (address === '') {
                address = 'San Jose, CA';
            }
            // Geocode the address and handle the result
            geocoder.geocode({ 'address': address }, function(results, status) {
                if (status === 'OK') {
                    var location = results[0].geometry.location;
                    
                    // Center the map on the geocoded location
                    map.setCenter(location);
        
                    // Create a circle around the location
                    var radius = document.getElementById("location_slider").value * 1609.34; // Convert miles to meters
                    var circle = new google.maps.Circle({
                        strokeColor: '#FF0000',
                        strokeOpacity: 0.8,
                        strokeWeight: 2,
                        fillColor: '#FF0000',
                        fillOpacity: 0.35,
                        map: map,
                        center: location,
                        radius: radius
                    });
        
                    // Create a marker at the geocoded location
                    var mainMarker = new google.maps.Marker({
                        position: location,
                        map: map,
                        title: 'Main Location', // Custom title for the special pin
                        icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' // Custom icon for the special pin
                    });
        
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>

    <style>
        /* Set the size of the map container */
        #map {
            height: 100vh;
            width: 100%;
            z-index: 0;
        }
    </style>

    <!-- Shashhank results filter -->
    <div class="leftbar">
        <div class="location_search_module">
            <div class="location_search_module_1">
                <input type="text" id="location_search" name="searchbox" placeholder="Address, ZIP Code, ...">
                <div class="search_icon" onclick="addCurrentLocation()"></div>
            </div>
            <!-- <div class="icon_circle">
                <div class="icon"></div>
            </div> -->
        </div>
        <script>
            function addCurrentLocation() {
                var address = document.getElementById("location_search").value;
                
                addCenter(address);
            }
        </script>
        <div class="leftbar_container_1">
            <div id="your_rentals">
                <div class="your_rentals_icon"></div>
                <div class="your_rentals_text"> Your rentals </div>
            </div>
            <div id="your_rentings">
                <div class="your_rentings_icon"></div>
                <div class="your_rentings_text"> Your rentings </div>
            </div>
            <div id="messages">
                <div class="messages_icon"></div>
                <div class="messages_text"> Messages </div>
            </div>
            <div id="friends">
                <div class="friends_icon"></div>
                <div class="friends_text"> Friends </div>
            </div>
        </div>


        <div class="line"></div>

        <div class="searchrent_module">
            <input type="text" id="interested_rents" name="searchbox" placeholder="What's in your mind?...">
            <div class="searchrent_icon" onclick="performSearch(); addCurrentLocation()"></div>
        </div>

        <div class="category_module">
            <div class="category_icon_background">
                <div class="category_icon"></div>
            </div>
            <div class="category_text"> Category</div>
            <div class="category_dropdown_arrow"></div>
        </div>

        <div class="category_list">
            <ul class="category-dropdown-content">
                <li><a href="#">Bikes</a></li>
                <li><a href="#">Scooters</a></li>
                <li><a href="#">Google Cars</a></li>
                <li><a href="#">Trucks</a></li>
                <li><a href="#">SUVs</a></li>
                <li><a href="#">Skateboards</a></li>
            </ul>
        </div>

        <div class="features_module">
            <div class="features_icon_background">
                <div class="features_icon"></div>
            </div>
            <div class="features_text"> Features</div>
            <div class="features_dropdown_arrow"></div>
        </div>

        <div class="features_list">
            <ul class="features-dropdown-content">
                <li><a href="#">Four-wheel</a></li>
                <li><a href="#">Electric</a></li>
                <li><a href="#">Tough terrains</a></li>
                <li><a href="#">Good-looking</a></li>
                <li><a href="#">Auto-pilot</a></li>
                <li><a href="#">Trending</a></li>
            </ul>
        </div>

        <div id="price">
            <div id="price_container_1">
                <div class="prices_icon"></div>
                <div class="prices_text"> Price </div>
            </div>
            <div id="price_container_2">
                <input type="text" id="min_price" name="min_price" placeholder="Min.">
                <div class="to"> to </div>
                <input type="text" id="max_price" name="max_price" placeholder="Max.">
            </div>
        </div>

        <div id="location">
            <div id="location_container_1">
                <div class="location_icon"></div>
                <div class="location_text"> Location (miles) </div>
            </div>
            <div id="location_container_2">
                <input type="range" min="0" max="100" value="5" step="5" id="location_slider" onchange="addCurrentLocation()">
                <div class="location_value"> 5 miles </div>
            </div>
        </div>

        <div id="duration">
            <div id="duration_container_1">
                <div class="durations_icon"></div>
                <div class="durations_text"> Duration </div>
            </div>
            <div id="duration_container_2">
                <input type="text" id="min_duration" name="min_duration" placeholder="Number">
                <div id="duration_container_3">
                    <div class="duration-dropdown-module"> Period 
                    </div>
                    <div class="duration_dropdown_arrow"> </div>
                </div>
                <ul class="duration-dropdown-content">
                    <li class="duration-dropdown-content-hours"><a href="#">Hour(s)</a></li>
                    <li class="duration-dropdown-content-days"><a href="#">Day(s)</a></li>
                    <li class="duration-dropdown-content-weeks"><a href="#">Week(s)</a></li>
                    <li class="duration-dropdown-content-months"><a href="#">Month(s)</a></li>
                </ul>
            </div>
        </div>

        <div id="condition">
            <div id="condition_module">
                <div class="condition_icon"></div>
                <div class="condition_text"> Condition </div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Excellent </div>
                <div class="condition_checkbox_excellent"></div>
                <div class="condition_checkbox_excellent_module">
                    <div class="condition_checkbox_excellent_icon"></div>
                    <div class="condition_checkbox_excellent_square1"></div>
                    <div class="condition_checkbox_excellent_square2"></div>
                </div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Good </div>
                <div class="condition_checkbox_good"></div>
                <div class="condition_checkbox_good_module">
                    <div class="condition_checkbox_good_icon"></div>
                    <div class="condition_checkbox_good_square1"></div>
                    <div class="condition_checkbox_good_square2"></div>
                </div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Fair </div>
                <div class="condition_checkbox_fair"></div>
                <div class="condition_checkbox_fair_module">
                    <div class="condition_checkbox_fair_icon"></div>
                    <div class="condition_checkbox_fair_square1"></div>
                    <div class="condition_checkbox_fair_square2"></div>
                </div>
            </div>
        </div>
        <div class="leftbar_space"></div>
    </div>

    <!-- Alicia signup/login -->
    <div class="homepage_bar">
        <img src="images/image2.png" alt = "" class="logo">
        <div class="shopping_icon"></div>
        <div tabindex="0" id="signup_container">
            <div class="signup_login_button">
                <div class="signup_login_text"> 
                    <% if (uname != null && userId != null) { %>
                        Welcome, <%= uname %>
                    <% } else { %>
                        Signup / Login
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Alicia shopping cart populate -->
    <div class="cart_module">
        <!-- <div class="cart_list">
            <div class="cart_item">
                <div class="cart_item_module">
                    <div class="cart_item_title"> Waymo 5th Generation for Rent! Funny isn't it? </div>
                    <div class="cart_item_module_2">
                        <div class="cart_item_duration_icon"></div>
                        <div class="cart_item_duration"> 126000 </div>
                    </div>
                </div>
                <div class="cart_item_quantity"> x15 </div>
                <div class="cart_item_price"> $30 </div>
            </div> -->
            <%
            int total = 0;
            try {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

                Statement stmt = con.createStatement();

                String getCartQuery = String.format("SELECT item_id, name, cart.quantity, duration, price_per_hour, price_per_day, price_per_week, price_per_month FROM cart, items, rentsfor, prices WHERE cart.ItemID = items.item_id AND UserID = %s AND cart.ItemID = rentsfor.ItemID AND prices.prices_id = rentsfor.ItemID;",userId);
                ResultSet rs = stmt.executeQuery(getCartQuery);

                out.println("<div class='cart_list'>");
                while(rs.next()) {
                    out.println("<div class='cart_item'>");
                    out.println("<div class='cart_item_module'>");
                    out.println("<div class='cart_item_title'>" + rs.getString("name") + "</div>");
                    int duration = rs.getInt("duration");

                    out.println("<div class='cart_item_module_2'>");
                    out.println("<div class='cart_item_duration_icon'></div>");
                    out.println("<div class='cart_item_duration'> " + String.valueOf(duration) + " </div>");
                    out.println("</div>");
                    out.println("</div>");
                    int quantity = rs.getInt("quantity");
                    out.println("<div class='cart_item_quantity'> x" + String.valueOf(quantity) + "</div>");
                    int price = rs.getInt("price_per_hour");
                    int priceXQuantity = quantity * price;
                    total += priceXQuantity;
                    out.println("<div class='cart_item_price'> $" + String.valueOf(priceXQuantity) + "</div>");
                    out.println("</div>");
                }
                out.println("</div>");

                stmt.close();
                con.close();
            } catch(SQLException e) {
                e.printStackTrace(); 
            }
        %>

        <div class="cart_module_line"></div>
        <div class="cart_total_module">
            <div class="cart_total_text"> Total </div>
            <div class="cart_total_price"> $<%=total%> </div>
        </div>
        <div class="rent_now"> Rent now </div>
    </div>

    <!-- Alicia cart payment submit -->
    <div class="cart_payment_module">
        <input type="text" id="card_full_name" placeholder="Full Name">
        <input type="text" id="credit_card_number" placeholder="Credit Card Number">
        <input type="text" class="card_expiration_date" placeholder="MM/YY">
        <input type="text" id="card_cvv" placeholder="CVV">
        <div class="cart_payment_back"> Back </div>
        <input type="submit" name="card_submit" value="Checkout" class="cart_payment_submit">

        <%
            if (request.getParameter("card_submit") != null && !userId.equals("0")) {
                try {
                    java.sql.Connection con;
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);
        
                    Statement stmt = con.createStatement();

                    // add to rent history
                    String getCartQuery = String.format("SELECT * FROM cart WHERE UserID=%s;",userId);
                    ResultSet rs = stmt.executeQuery(getCartQuery);

                    ArrayList<int[]> cart = new ArrayList<int[]>();
                    while(rs.next()) {
                        int[] cartItem = new int[3];
                        cartItem[0] = rs.getInt("UserID");
                        cartItem[1] = rs.getInt("ItemID");
                        cartItem[2] = rs.getInt("duration");
                        cart.add(cartItem);
                    }

                    for (int i = 0; i < cart.size(); i++) {
                        int[] cartItem = cart.get(i);
                        out.println(cartItem[1]);
                    }

                    // probably can remove this whole loop and combine with while loop
                    for (int i = 0; i < cart.size(); i++) {
                        int[] cartItem = cart.get(i);
                        
                        String getLastRentID = "SELECT history_id FROM rent_history ORDER BY history_id DESC LIMIT 1";
                        ResultSet rs2 = stmt.executeQuery(getLastRentID);
                        rs2.next();
                        int newID = rs2.getInt(1) + 1;
                        out.println(newID);

                        String setSavesQuery = String.format("INSERT INTO rentle.saves (UserID, RentHistoryID) VALUES (%s, %s)", userId, newID);
                        int ri = stmt.executeUpdate(setSavesQuery);
                        

                        LocalDateTime now = LocalDateTime.now();
                        int duration = cartItem[2];
                        LocalDateTime expirationDate = now.plusSeconds(duration);

                        int itemID = cartItem[1];
                        String setRentHistoryQuery = String.format("INSERT INTO rentle.rent_history (history_id, rentdate, ItemID, rentexpiration) VALUES (%s, '%s', %s, '%s');", String.valueOf(newID), now.toString(), String.valueOf(itemID), expirationDate.toString());     
                        
                        out.println(setRentHistoryQuery);
                        ri = stmt.executeUpdate(setRentHistoryQuery);
                    }

                    //remove from cart
                    String removeFromCartQuery = String.format("DELETE FROM rentle.cart WHERE UserID=%s",userId);
                    int ri = stmt.executeUpdate(removeFromCartQuery);
                } catch(Exception e) {
                    e.printStackTrace(); 
                }
            }
        %>
    </div>
        
    <!-- Alicia signup login module -->
    <div id="login-module">
        <div class="login-background">
            <div class="username"> Username </div>
            <input type="text" id="username" name="searchbox" placeholder="Email, username, or phone number">
            <div class="password"> Password </div>
            <input type="password" id="password" name="searchbox" placeholder="">
            <div id="login-button-module">
                <div class="login_button_background"></div>
                <div class="login_text" onclick="login()"> Login </div>
            </div>
            <div id="signup_notification_component">
                <div class="not_a_member_text"> Not a member? </div>
                <div class="signup_hyperlink" onclick="window.location.href='/Rentle/sign-up.jsp'">Sign up</div>
            </div>
        </div>
    </div>
    
    <div id="loggedin_notification_component">
        <div class="view-profile-button">Profile</div>
        <div class="submit" onclick="logoutUser()"> Submit </div>
    </div>

    <script>
        function logoutUser() {
            $('#user_id').text(null); // Clear the user ID
            location.reload(true);
        }
    </script>


    <div id="wrapper">
        <div class="rectangle">
            <div class="rectangle_center_component" id="rectangle_center_component"></div>
        </div>
    </div>
    <div class="rightbar" id="rightbar">

        <div class="add_item"> Add + </div>
        <div class="sort_module">
            <div class="sort_text"> Sort by </div>
            <div class="sort_dropdown_trigger"></div>
        </div>
        <div class="sort_list">
            <ul class="sort-dropdown-content">
                <li class="sort-dropdown-content-price"><a href="#">Price: low to high</a></li>
                <li class="sort-dropdown-content-location"><a href="#">Location: closest to furthest</a></li>
                <li class="sort-dropdown-content-date-listed"><a href="#">Date listed: newest to oldest</a></li>
            </ul>
        </div>
        <div class="grid_container" id="results">
            <%
            Connection conGridContainer = null;
            Statement stmtGridContainer = null;
            ResultSet rsGridContainer = null;
            List<String> photoArray = new ArrayList<>();
            List<String> nameArray = new ArrayList<>();
            List<String> locationArray = new ArrayList<>();
            List<String> categoryArray = new ArrayList<>();
            List<String> featuresArray = new ArrayList<>();
            List<String> priceArray = new ArrayList<>();
        
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conGridContainer = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
        
                stmtGridContainer = conGridContainer.createStatement();
                String photoString = "SELECT photo FROM photos " +
                                     "JOIN (SELECT ItemID AS item_id, MIN(PhotoID) AS photo_id " +
                                     "FROM rentle.contains GROUP BY ItemID) AS new_photos USING (photo_id)";
                rsGridContainer = stmtGridContainer.executeQuery(photoString);

                while (rsGridContainer.next()) {
                    String newPhoto = rsGridContainer.getString(1).replace("./Images/", "images/");
                    photoArray.add(newPhoto);
                }
                String nameAndLocationString = "SELECT name, location FROM items";
                rsGridContainer = stmtGridContainer.executeQuery(nameAndLocationString);

                while (rsGridContainer.next()) {
                    nameArray.add(rsGridContainer.getString(1));
                    locationArray.add(rsGridContainer.getString(2));
                }

                String categoryAndFeaturesString = "SELECT category_name, features_name FROM category " +
                                                   "JOIN (SELECT ItemID AS item_id, MIN(CategoryID) AS category_id " +
                                                   "FROM rentle.has GROUP BY ItemID) AS new_category USING (category_id) " +
                                                   "JOIN (SELECT CategoryID AS category_id, MIN(FeaturesID) AS features_id " +
                                                   "FROM rentle.consistsof GROUP BY CategoryID) AS new_features USING (category_id) " +
                                                   "JOIN features USING (features_id)";
                rsGridContainer = stmtGridContainer.executeQuery(categoryAndFeaturesString);

                while (rsGridContainer.next()) {
                    categoryArray.add(rsGridContainer.getString(1));
                    featuresArray.add(rsGridContainer.getString(2));
                }
        
                String priceString = "SELECT " +
                                     "    LEAST( " +
                                     "        COALESCE(p.price_per_hour, 9999999), " +
                                     "        COALESCE(p.price_per_day, 9999999), " +
                                     "        COALESCE(p.price_per_week, 9999999), " +
                                     "        COALESCE(p.price_per_month, 9999999) " +
                                     "    ) AS minimum_price " +
                                     "FROM (SELECT ItemID AS item_id, MAX(PricesID) AS prices_id " +
                                     "      FROM rentle.rentsfor " +
                                     "      GROUP BY ItemID) AS new_price " +
                                     "JOIN prices p ON new_price.prices_id = p.prices_id " +
                                     "WHERE p.price_per_hour IS NOT NULL " +
                                     "   OR p.price_per_day IS NOT NULL " +
                                     "   OR p.price_per_week IS NOT NULL " +
                                     "   OR p.price_per_month IS NOT NULL";
                rsGridContainer = stmtGridContainer.executeQuery(priceString);

                while (rsGridContainer.next()) {
                    priceArray.add(rsGridContainer.getString(1));
                }
                for (int i = 0; i < photoArray.size(); i++) {
            %>
            <div class="grid_item">
                <img src="<%=photoArray.get(i)%>" alt="" class="item_image">
                <div class="grid_item_module_1">
                    <div class="grid_item_module_2">
                        <div class="item_name"> <%= nameArray.get(i) %> </div>
                        <div class="item_module_1">
                            <div class="item_category"> <%= categoryArray.get(i) %> - </div>
                            <div class="item_feature"> <%= featuresArray.get(i) %> </div>
                        </div>
                        <div class="item_location"> <%= locationArray.get(i) %> </div>
                    </div>
                    <div class="item_price"> $<%= priceArray.get(i) %> </div>
                </div>
            </div>
            <%
                }
            } catch (SQLException e) {
                e.printStackTrace(); 
            } finally {
                try {
                    if (rsGridContainer != null) rsGridContainer.close();
                    if (stmtGridContainer != null) stmtGridContainer.close();
                    if (conGridContainer != null) conGridContainer.close();
                } catch (SQLException e) {
                    e.printStackTrace(); 
                }
            }
            %>
        </div>
    </div>

    <div id="your_rentals_view">
        <div id="your_rentals_top_component">
            <input type="text" id="rentals_search" name="searchbox" placeholder="Title, category, location, date, ...">
            <div id="past_rentals"> Past</div>
            <div id="current_rentals"> Current</div>
        </div>

        <div id="your_rentals_past_grid_container">
            <div class="your_rentals_past_grid_item">  
                <img src="image3.png" alt = "" class="your_rentals_past_grid_item_image">
                <div class="your_rentals_past_module">
                    <div class="your_rentals_past_grid_item_title"> Bicycle for rent! </div>
                    <div class="your_rentals_past_category_module">
                        <div class="your_rentals_past_grid_item_category"> Category: </div>
                        <div class="your_rentals_past_grid_item_category_name"> Bike </div>
                    </div>
                    <div class="your_rentals_past_features_module">
                        <div class="your_rentals_past_grid_item_features"> Features: </div>
                        <div class="your_rentals_past_grid_item_features_name"> Multiple technology, </div>
                        <div class="your_rentals_past_grid_item_features_name"> Adjustable seat </div>
                    </div>
                    <div class="your_rentals_past_location_module">
                        <div class="your_rentals_past_grid_item_location"> Location: </div>
                        <div class="your_rentals_past_grid_item_location_name"> San Jose, CA </div>
                    </div>
                    <div class="your_rentals_past_date_module">
                        <div class="your_rentals_past_grid_item_date"> Date rented: </div>
                        <div class="your_rentals_past_grid_item_date_name"> July 18th, 2024 </div>
                    </div>
                    <div class="your_rentals_past_duration_module">
                        <div class="your_rentals_past_grid_item_duration"> Duration: </div>
                        <div class="your_rentals_past_grid_item_duration_name"> 3 hours </div>
                    </div>
                    <div class="your_rentals_past_price_module">
                        <div class="your_rentals_past_grid_item_price"> Price: </div>
                        <div class="your_rentals_past_grid_item_price_name"> $60 </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="your_rentals_current_grid_container">
            <div class="your_rentals_current_grid_item">  
                <img src="image4.png" alt = "" class="your_rentals_current_grid_item_image">
                <div class="your_rentals_current_module">
                    <div class="your_rentals_current_grid_item_title"> Waymo 5th Generation! </div>
                    <div class="your_rentals_current_category_module">
                        <div class="your_rentals_current_grid_item_category"> Category: </div>
                        <div class="your_rentals_current_grid_item_category_name"> Automobile </div>
                    </div>
                    <div class="your_rentals_current_features_module">
                        <div class="your_rentals_current_grid_item_features"> Features: </div>
                        <div class="your_rentals_current_grid_item_features_name"> Self-driving, </div>
                        <div class="your_rentals_current_grid_item_features_name"> Comfortable seats </div>
                    </div>
                    <div class="your_rentals_current_location_module">
                        <div class="your_rentals_current_grid_item_location"> Location: </div>
                        <div class="your_rentals_current_grid_item_location_name"> Mountain View, CA </div>
                    </div>
                    <div class="your_rentals_current_date_module">
                        <div class="your_rentals_current_grid_item_date"> Date created: </div>
                        <div class="your_rentals_current_grid_item_date_name"> July 19th, 2024 </div>
                    </div>
                    <div class="your_rentals_current_price_module">
                        <div class="your_rentals_current_grid_item_price"> Price: </div>
                        <div class="your_rentals_current_grid_item_price_name"> $8/hour, </div>
                        <div class="your_rentals_current_grid_item_price_name"> $20/week, </div>
                        <div class="your_rentals_current_grid_item_price_name"> $75/month </div>
                    </div>
                </div>
            </div>

            
        </div>
    </div>

    <!-- Alicia rentings view -->
    <div id="your_rentings_view">
        <div id="your_rentings_top_component">
            <input type="text" id="rentings_search" name="searchbox" placeholder="Title, category, location, date, ...">
            <div id="past_rentings"> Past</div>
            <div id="current_rentings"> Current</div>
        </div>
    
        <%
            ArrayList<int[]> pastInts = new ArrayList<int[]>();
            ArrayList<String[]> pastStrs = new ArrayList<String[]>();
            ArrayList<int[]> currentInts = new ArrayList<int[]>();
            ArrayList<String[]> currentStrs = new ArrayList<String[]>();
            try {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false&maxReconnects=10",user, password);

                Statement stmt = con.createStatement();

                String getRentingsQuery = String.format("SELECT item_id, name, description, location, quantity, rentdate, rentexpiration, price_per_hour, photo_id, photo, category_name FROM items, rent_history, saves, prices, rentsfor, contains, photos, has, category WHERE UserID=%s AND RentHistoryID=history_id AND rent_history.ItemID=item_id AND rentsfor.ItemID=item_id AND prices_id=PricesID AND items.item_id = contains.ItemID AND contains.PhotoID = photos.photo_id AND items.item_id = has.ItemID AND has.CategoryID = category.category_id;", userId);
                ResultSet rs = stmt.executeQuery(getRentingsQuery);
                
                while(rs.next()) {
                    int[] itemInts = new int[5];
                    String[] itemStrs = new String[7];
                    String expirationString = rs.getString("rentexpiration").replace(" ","T");
                    // out.println(expirationString);
                    LocalDateTime now = LocalDateTime.now();
                    LocalDateTime expirationDate = LocalDateTime.parse(expirationString);

                    String returnDateString = expirationDate.format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM));
                    String checkoutDateString = now.format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM));

                    itemInts[0] = rs.getInt("item_id");
                    itemStrs[0] = rs.getString("name");
                    itemStrs[1] = rs.getString("description");
                    itemStrs[2] = rs.getString("location");
                    itemInts[1] = rs.getInt("quantity");
                    itemStrs[3] = checkoutDateString;
                    itemStrs[4] = returnDateString;
                    itemInts[2] = rs.getInt("price_per_hour");
                    itemInts[3] = rs.getInt("photo_id");
                    itemStrs[5] = rs.getString("photo");
                    itemStrs[6] = rs.getString("category_name");

                    if (now.isAfter(expirationDate)) {
                        pastInts.add(itemInts);
                        pastStrs.add(itemStrs);
                    } else {
                        //int timeRemaining = now.until(expirationDate, ChronoUnit.SECONDS);
                        long timeRemaining = ChronoUnit.SECONDS.between(now, expirationDate);
                        itemInts[4] = Math.toIntExact(timeRemaining);
                        currentInts.add(itemInts);
                        currentStrs.add(itemStrs);
                    }
                }

            } catch(SQLException e) {
                e.printStackTrace(); 
            }
        %>

        <div id="your_rentings_past_grid_container">
            <%
                // cycle through past arraylists
                for (int i = 0; i < pastInts.size(); i++) {
                    int[] itemInts = pastInts.get(i);
                    String[] itemStrs = pastStrs.get(i);
                    String image = "images/"+itemStrs[5];
            %>
            <div class="your_rentings_past_grid_item">  
                <img src=<%=image%> alt = "" class="your_rentings_past_grid_item_image">
                <div class="your_rentings_past_module">
                    <div class="your_rentings_past_grid_item_title"> <%=itemStrs[0]%> </div>
                    <div class="your_rentings_past_category_module">
                        <div class="your_rentings_past_grid_item_category"> Category: </div>
                        <div class="your_rentings_past_grid_item_category_name"> <%=itemStrs[6]%> </div>
                    </div>
                    <div class="your_rentings_past_features_module">
                        <div class="your_rentings_past_grid_item_features"> Description: </div>
                        <div class="your_rentings_past_grid_item_features_name"> <%=itemStrs[1]%> </div>
                    </div>
                    <div class="your_rentings_past_location_module">
                        <div class="your_rentings_past_grid_item_location"> Location: </div>
                        <div class="your_rentings_past_grid_item_location_name"> <%=itemStrs[2]%> </div>
                    </div>
                    <div class="your_rentings_past_date_module">
                        <div class="your_rentings_past_grid_item_date"> Returned Date: </div>
                        <div class="your_rentings_past_grid_item_date_name"> <%=itemStrs[4]%> </div>
                    </div>
                    <div class="your_rentings_past_duration_module">
                        <div class="your_rentings_past_grid_item_duration"> Quantity: </div>
                        <div class="your_rentings_past_grid_item_duration_name"> <%=itemInts[1]%> </div>
                    </div>
                    <div class="your_rentings_past_price_module">
                        <div class="your_rentings_past_grid_item_price"> Price: </div>
                        <div class="your_rentings_past_grid_item_price_name"> $<%=itemInts[2]%> </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <div id="your_rentings_current_grid_container">
            <%
                // cycle through current arraylists
                for (int i = 0; i < currentInts.size(); i++) {
                    int[] itemInts = currentInts.get(i);
                    String[] itemStrs = currentStrs.get(i);
                    String image = "images/"+itemStrs[5];
                    
            %>
            <div class="your_rentings_current_grid_item">  
                <img src=<%=image%> alt = "" class="your_rentings_current_grid_item_image">
                <div class="your_rentings_current_module">
                    <div class="your_rentings_current_grid_item_title"> <%=itemStrs[0]%> </div>
                    <div class="your_rentings_current_category_module">
                        <div class="your_rentings_current_grid_item_category"> Category: </div>
                        <div class="your_rentings_current_grid_item_category_name"> <%=itemStrs[6]%> </div>
                    </div>
                    <div class="your_rentings_current_features_module">
                        <div class="your_rentings_current_grid_item_features"> Description: </div>
                        <div class="your_rentings_current_grid_item_features_name"> <%=itemStrs[1]%> </div>
                    </div>
                    <div class="your_rentings_current_location_module">
                        <div class="your_rentings_current_grid_item_location"> Location: </div>
                        <div class="your_rentings_current_grid_item_location_name"> <%=itemStrs[2]%> </div>
                    </div>
                    <div class="your_rentings_current_date_module">
                        <div class="your_rentings_current_grid_item_date"> Checkout Date: </div>
                        <div class="your_rentings_current_grid_item_date_name"> <%=itemStrs[3]%> </div>
                    </div>
                    <div class="your_rentings_current_duration_module">
                        <div class="your_rentings_current_grid_item_duration"> Quantity: </div>
                        <div class="your_rentings_current_grid_item_duration_name"> <%=itemInts[1]%> </div>
                    </div>
                    <div class="your_rentings_current_price_module">
                        <div class="your_rentings_current_grid_item_price"> Price: </div>
                        <div class="your_rentings_current_grid_item_price_name"> $<%=itemInts[2]%> </div>
                    </div>
                </div>
                 <div class="your_rentings_current_time_remaining_module">
                    <div class="your_rentings_current_grid_item_time_remaining"> Time remaining </div>
                    <div class="your_rentings_current_grid_item_time_remaining_name"><%=itemInts[4]%></div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    
    <div id="messages_view">
        <div class="currentGroupId" style="display:none"> <%= currentGroupId %> </div> 
        <div class="messages_view_module_1">
            <div class="your_messages_text"> Messages </div>
            <div class="your_messages_add_group_chat" > + </div>
            <div class="your_messages_add_group_chat_new_group_id"> </div>
        </div>

        <div class="your_messages_add_group_chat_people_grid">
            <!-- your_messages_add_group_chat_people_grid_item, your_messages_add_group_chat_people_grid_item_user_id, your_messages_add_group_chat_people_grid_name -->
            <input type="text" class="your_messages_add_group_chat_text" placeholder="Chat...">
        </div>

        <div class="your_messages_add_group_chat_module">
            <div class="your_messages_add_group_chat_grid">
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
                String query5 = "(SELECT DISTINCT u.user_id, u.profile_picture, u.first_name, u.last_name " +
               "FROM rentle.friends f " +
               "JOIN rentle.user u ON ((FriendUserID1 = ? AND u.user_id = FriendUserID2) " +
               "OR (FriendUserID2 = ? AND u.user_id = FriendUserID1))) " +

               "UNION " +

               "(SELECT u.user_id, u.profile_picture, u.first_name, u.last_name " +
               "FROM rentle.user u " +
               "WHERE u.user_id != ? AND u.user_id NOT IN ( " +
                   "SELECT DISTINCT CASE WHEN FriendUserID1 = ? THEN FriendUserID2 ELSE FriendUserID1 END " +
                   "FROM rentle.friends " +
                   "WHERE FriendUserID1 = ? OR FriendUserID2 = ?)) " +
               "LIMIT 20";


                PreparedStatement pstmt = conn.prepareStatement(query5);
                pstmt.setString(1, userId);
                pstmt.setString(2, userId);
                pstmt.setString(3, userId);
                pstmt.setString(4, userId);
                pstmt.setString(5, userId);
                pstmt.setString(6, userId);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String addUserId = rs.getString(1);
                    String addProfilePicture = rs.getString(2);
                    String addfirstName = rs.getString(3);
                    String addLastName = rs.getString(4);
                    String gridItemName = addfirstName + " " + addLastName;
            %>
                <div class="your_messages_add_group_chat_grid_item">
                    <div class="your_messages_add_group_chat_user_id" style="display:none"> <%=addUserId%></div>
                    <img src="<%=addProfilePicture%>" class="your_messages_add_group_chat_grid_item_profile_picture">
                    <div class="your_messages_add_group_chat_grid_item_username"> <%=gridItemName%> </div>
                </div>
            <%
                }

            } catch (SQLException e) {
                e.printStackTrace(); 
            }
            %>
            </div>
        </div>

        <input type="text" id="people_search" name="searchbox" placeholder="Who are you finding?">

        <div id="people_messages_grid">
            <!-- <div class="people_messages_item">
                <div class="group_id" style="display:none"> </div>
                <img src="" alt = "" class="people_messages_profile_pic">
                <div class="people_messages_module">
                    <div class="people_messages_name"></div>
                    <div class="people_messages_content"></div>
                </div>
            </div> -->
        </div>

        <div class="messages_vertical_bar"></div>
        <div class="messages_area">
            <div class="messages_area_grid"></div>
        </div>

        <div class="message_input_module">
            <textarea class="message_input" placeholder="Type anything!"></textarea>
            <div class="message_enter" onclick="addText()"> Go</div>
        </div>
    </div>

    <script>
        function fetchNewGroupId() {
            $.ajax({
                url: 'JSPMessageFiles/newGroupId.jsp',
                method: 'POST',
                success: function(data) {
                    $('.your_messages_add_group_chat_new_group_id').text(data);
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching group ID:', error);
                }
            });
        }

        $('.your_messages_add_group_chat').click(function() {
            addGroup();
            fetchNewGroupId();
            var newGroupId1 = $('.your_messages_add_group_chat_new_group_id').text().trim();
            $('.currentGroupId').text(newGroupId1); 

            if ($('.your_messages_add_group_chat_module').css('display') === 'none') {
                $('.your_messages_add_group_chat_module').css('display', 'block');
            }
            else {
                $('.your_messages_add_group_chat_module').css('display', 'none');
            }
            if ($('.your_messages_add_group_chat_people_grid').css('display') === 'none') {
                $('.your_messages_add_group_chat_people_grid').css('display', 'flex');
            }
            else {
                $('.your_messages_add_group_chat_people_grid').css('display', 'none');
            }
            reloaddata();
        });

        $('.your_messages_add_group_chat_grid').on('click', '.your_messages_add_group_chat_grid_item', function() {
            var name = $(this).find('.your_messages_add_group_chat_grid_item_username').text().trim();
            var id = $(this).find('.your_messages_add_group_chat_user_id').text().trim();
            var profilePic = $(this).find('.your_messages_add_group_chat_grid_item_profile_picture').attr('src');
            
            var $gridItemUserId = $('<div></div>');
            var $gridItemName = $('<div></div>');
            var $gridItem = $('<div></div>');
            var $gridItemProfilePic = $('<div></div>');

            $gridItem.addClass('your_messages_add_group_chat_people_grid_item');
            $gridItemUserId.addClass('your_messages_add_group_chat_people_grid_item_user_id'); 
            $gridItemName.addClass('your_messages_add_group_chat_people_grid_item_name');
            $gridItemProfilePic.addClass('your_messages_add_group_chat_people_grid_item_profile_picture');

            $gridItemUserId.text(id);
            $gridItemUserId.css('display', 'none');
            $gridItemName.text(name);
            $gridItemProfilePic.text(profilePic);
            $gridItemProfilePic.css('display', 'none');

            var $gridItemRemove = $('<div></div>');
            $gridItemRemove.addClass('your_messages_add_group_chat_people_grid_item_remove');

            $gridItem.append($gridItemUserId);
            $gridItem.append($gridItemName);
            $gridItem.append($gridItemRemove);
            $gridItem.append($gridItemProfilePic);

            $gridItem.appendTo($('.your_messages_add_group_chat_people_grid'));
            $gridItem.insertBefore($('.your_messages_add_group_chat_text'));
            addGroup();
            $(this).remove();
            reloadDataGroup();
            var newGroupId1 = $('.your_messages_add_group_chat_new_group_id').text().trim();
            $('.currentGroupId').text(newGroupId1); 
            reloaddata();
        });

        $('.your_messages_add_group_chat_people_grid').on('click', '.your_messages_add_group_chat_people_grid_item_remove', function() {
            var designatedUserId = $(this).siblings('.your_messages_add_group_chat_people_grid_item_user_id').text().trim();
            var designatedProfilePic = $(this).siblings('.your_messages_add_group_chat_people_grid_item_profile_picture').text().trim();
            var designatedUserName = $(this).siblings('.your_messages_add_group_chat_people_grid_item_name').text().trim();

            var $addGroupChat = $('<div></div>');
            var $addUserId = $('<div></div>');
            var $addProfilePic = $('<img>');
            var $addUserName = $('<div></div>');

            $addGroupChat.addClass('your_messages_add_group_chat_grid_item');
            $addUserId.addClass('your_messages_add_group_chat_user_id');
            $addProfilePic.addClass('your_messages_add_group_chat_grid_item_profile_picture');
            $addUserName.addClass('your_messages_add_group_chat_grid_item_username');

            $addUserId.text(designatedUserId);
            $addProfilePic.attr('src', designatedProfilePic);
            $addUserId.text(designatedUserId);
            $addUserName.text(designatedUserName);
            $addUserId.css('display', 'none');

            $addGroupChat.append($addUserId);
            $addGroupChat.append($addProfilePic);
            $addGroupChat.append($addUserName);
            
            $('.your_messages_add_group_chat_grid').prepend($addGroupChat);

            $(this).closest('.your_messages_add_group_chat_people_grid_item').remove();
            addGroup();
            reloadDataGroup();
            reloaddata();
        });

        $('#people_messages_grid').on('click', '.people_messages_item', function() {
            var lastItem = $('#people_messages_grid').children().last();
            var name = lastItem.find('.people_messages_name').text().trim();
            if (name === "") {
                console.log("name is null");
                deleteLastItem();
            }
            var newGroupId = $(this).find('.group_id').text().trim();
            $('.currentGroupId').text(newGroupId); 
            console.log($('.currentGroupId').text())
 
        });


        $(document).click(function(event) {
            if (!$(event.target).closest('.your_messages_add_group_chat_module, .your_messages_add_group_chat_people_grid, .your_messages_add_group_chat, .your_messages_add_group_chat_grid_item, .your_messages_add_group_chat_people_grid_item_remove').length) {
                $('.your_messages_add_group_chat_module').css('display', 'none');
                $('.your_messages_add_group_chat_people_grid').css('display', 'none');
            }
            reloaddata();
        });

    </script>

    <script>
        function uploadFiles() {
            var formData = new FormData();
            var files = document.getElementById("file-upload").files;
            
            for (var i = 0; i < files.length; i++) {
                console.log(i);
                formData.append("file-upload", files[i]);
            }

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "fileuploadservlet", true);

            xhr.onload = function() {
                if (xhr.status === 200) {
                    // Handle successful upload here
                    console.log("Upload successful: " + xhr.responseText);
                } else {
                    // Handle error here
                    console.error("Upload failed: " + xhr.responseText);
                }
            };

            xhr.send(formData);
        }
    </script>

    <div id="friends_view"></div>

    <!-- Shashhank add item and upload files -->
    <div class="add_item_module">
        <div id="add_photos_grid">
            <div class="add_photo_module">
                <label for="file-upload" id="add_photo_background"> + </label>
                <input type="file" id="file-upload" accept="image/*" multiple>
            </div>
        </div>

        <div class="add_item_middle_module_1">
            <div class="add_item_title">
                <div class="item_title"> Item Title </div>
                <input type="text" id="add_item_title_input" placeholder="What is the main thing you want to say?..."> 
            </div>
            <div class="add_item_category">
                <div class="add_item_category_name"> Category </div>
                <div class="add_item_category_module"> Bike, Scooters, ... 
                    <div class="add_item_category_dropdown_arrow"></div>
                </div>
                <ul class="add_item_category_dropdown_content">
                    <li><a href="#">Bike</a></li>
                    <li><a href="#">Google Cars</a></li>
                    <li><a href="#">Scooters</a></li>
                    <li><a href="#">Trucks</a></li>
                    <li><a href="#">SUVs</a></li>
                    <li><a href="#">Skateboards</a></li>
                </ul>
            </div>
            <div class="add_item_condition">
                <div class="add_item_condition_name"> Condition </div>
                <div class="add_item_condition_module"> Excellent, Good, ... 
                    <div class="add_item_condition_dropdown_arrow"></div>
                </div>
                <ul class="add_item_condition_dropdown_content">
                    <li><a href="#">Excellent</a></li>
                    <li><a href="#">Good</a></li>
                    <li><a href="#">Fair</a></li>
                </ul>
            </div>
        </div>

        <div class="add_item_features_module">
            <div class="add_item_features_name"> Item Features</div>
            <div class="add_item_features_list">
                <div class="add_item_features_plus_icon"> + </div>
            </div>
        </div>

        <div class="add_items_features_type">
            <div class="space"></div>
            <input type="text" id="add_items_features_input" placeholder="Fill in the features...">
            <div class="add_items_features_icon"></div>
        </div>


        <div class="add_item_middle_module_2">
            <div class="add_item_description">
                <div class="item_description"> Item Description </div>
                <textarea id="add_item_description_input" placeholder="Write a few words about your product..."></textarea>
            </div>
            <div class="add_item_middle_module_3">
                <div class="add_item_location">
                    <div class="add_item_location_title"> Item Location </div>
                    <div class="item_location_input_module">
                        <input type="text" id="item_location_input_address" placeholder="Street Address">
                        <input type="text" id="item_location_input_city" placeholder="City">
                        <input type="text" id="item_location_input_state" placeholder="State">
                        <input type="text" id="item_location_input_zip_code" placeholder="ZIP Code">
                    </div>
                </div>

                <div class="add_item_price">
                    <div class="add_item_price_title"> Item Price </div>
                    <div class="item_price_input_module">
                        <input type="text" id="item_price_hour" placeholder="Price per hour">
                        <input type="text" id="item_price_day" placeholder="Price per day">
                        <input type="text" id="item_price_week" placeholder="Price per week">
                        <input type="text" id="item_price_month" placeholder="Price per month">
                    </div>
                </div>
            </div>
        </div>

        <div class="add_item_cancel_add_module">
            <div class="add_item_cancel"> Cancel </div>
            <div class="add_item_add"> Add </div>
        </div>
    </div>

    <script>
        function addItem() {
            // Save every photo using upload.jsp
            var fileInput = document.getElementById("file-upload");
            var files = fileInput.files;
            uploadFiles();
            
            var title = document.getElementById("add_item_title_input").value;
            var category = "Car"
            var condition = "Excellent"
            var features = [];
            var featureItems = document.getElementsByClassName("add_item_features_list")[0].children;
            for (var i = 0; i < featureItems.length - 1; i++) {
                features.push(featureItems[i].textContent.trim());
            }
            
            var filePaths = [];
            for (var i = 0; i < files.length; i++) {
                filePaths.push("./Images/" + files[i].name);
            }
                        
            var description = document.getElementById("add_item_description_input").value;
            var address = document.getElementById("item_location_input_address").value;
            var city = document.getElementById("item_location_input_city").value;
            var state = document.getElementById("item_location_input_state").value;
            var zipCode = document.getElementById("item_location_input_zip_code").value;
            
            var priceHour = document.getElementById("item_price_hour").value;
            var priceDay = document.getElementById("item_price_day").value;
            var priceWeek = document.getElementById("item_price_week").value;
            var priceMonth = document.getElementById("item_price_month").value;

            var currentUserId = document.getElementById("user_id").textContent.trim();
            
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "additem.jsp?title=" + encodeURIComponent(title) +
                            "&category=" + encodeURIComponent(category) +
                            "&condition=" + encodeURIComponent(condition) +
                            "&features=" + encodeURIComponent(JSON.stringify(features)) +
                            "&filePaths=" + encodeURIComponent(JSON.stringify(filePaths)) +
                            "&description=" + encodeURIComponent(description) +
                            "&address=" + encodeURIComponent(address) +
                            "&city=" + encodeURIComponent(city) +
                            "&state=" + encodeURIComponent(state) +
                            "&zipCode=" + encodeURIComponent(zipCode) +
                            "&priceHour=" + encodeURIComponent(priceHour) +
                            "&priceDay=" + encodeURIComponent(priceDay) +
                            "&priceWeek=" + encodeURIComponent(priceWeek) +
                            "&priceMonth=" + encodeURIComponent(priceMonth) + 
                            "&currentUserId=" + encodeURIComponent(currentUserId), true);
                            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log("True");
                    
                } else {
                    console.log("Failed");
                }
            };
            xhr.send();
        }
    </script>

    <script>
        function viewItem() {
            var currentItemId = $('.view_item_index').text().trim();
            var currentUserId = $('#user_id').text().trim();
            var xhr = new XMLHttpRequest();

            xhr.open("GET", "viewItem.jsp?currentItemId=" + encodeURIComponent(currentItemId) +
                            "&currentUserId=" + encodeURIComponent(currentUserId), true);
                            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        var existingElement = document.getElementsByClassName("view_item_module")[0];
                        existingElement.insertAdjacentHTML('afterbegin', xhr.responseText);
                        console.log("Success");
                    } catch (e) {
                        console.log("Nothing to worry!")
                    }
                }
            };
            xhr.send();
        }
    </script>

    <script>
        function performSearch() {
            var query = document.getElementById("interested_rents").value;
            var minPrice = document.getElementById("min_price").value;
            var maxPrice = document.getElementById("max_price").value;
            var duration = document.getElementById("min_duration").value;
            var durationCategory = $(".duration-dropdown-content li.active");
            if (durationCategory.length > 0) {
                durationCategory = durationCategory.text().trim();
            } else {
                durationCategory = "Hour(s)";
            }
            var category = "all";
            var feature = "all";
            var excellentCondition = false;
            var goodCondition = false;
            var fairCondition = false;
            // Check if the condition transform is equal to matrix()
            if ($(".condition_checkbox_excellent_square1").css('transform') === 'matrix(1, 0, 0, 1, 35, 0)') {
                excellentCondition = true;
            }
            if ($(".condition_checkbox_good_square1").css('transform') === 'matrix(1, 0, 0, 1, 35, 0)') {
                goodCondition = true;
            }
            
            if ($(".condition_checkbox_fair_square1").css('transform') === 'matrix(1, 0, 0, 1, 35, 0)') {
                fairCondition = true;
            }
            
            var activeItem = $('.category-dropdown-content li.active');
            if (activeItem.length > 0) {
                category = activeItem.text().trim();
            }
            
            activeItem = $('.features-dropdown-content li.active');
            if (activeItem.length > 0) {
                feature = activeItem.text().trim();
            }
            var location = document.getElementById("location_search").value;
            
            var sortBy = $(".sort-dropdown-content li.active");
            if (sortBy.length > 0) {
                sortBy = sortBy.text().trim();
            } else {
                sortBy = "Price";
            }

            console.log(query, minPrice, maxPrice, duration, durationCategory, category, feature, location, document.getElementById("location_slider").value, excellentCondition, goodCondition, fairCondition, sortBy);
                        
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "results.jsp?query=" + encodeURIComponent(query) +
                            "&minPrice=" + encodeURIComponent(minPrice) +
                            "&maxPrice=" + encodeURIComponent(maxPrice) +
                            "&duration=" + encodeURIComponent(duration) +
                            "&durationCategory=" + encodeURIComponent(durationCategory) +
                            "&category=" + encodeURIComponent(category) +
                            "&feature=" + encodeURIComponent(feature) +
                            "&location=" + encodeURIComponent(location) +
                            "&locationDistance=" + encodeURIComponent(document.getElementById("location_slider").value) +
                            "&excellentCondition=" + encodeURIComponent(excellentCondition) +
                            "&goodCondition=" + encodeURIComponent(goodCondition) +
                            "&fairCondition=" + encodeURIComponent(fairCondition) +
                            "&sortBy=" + encodeURIComponent(sortBy), true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("results").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>

    <script>
        // Debounce function to limit the rate of function calls
        function debounce(func, delay) {
            let timeoutId;
            return function(...args) {
                clearTimeout(timeoutId);
                timeoutId = setTimeout(() => {
                    func.apply(this, args);
                }, delay);
            };
        }

        // Debounced version of the getLocations function
        const debouncedGetLocations = debounce(getLocations, 500);

        // Set up MutationObserver to watch for changes in the .grid_container
        const gridContainer = document.querySelector('.grid_container');

        const observer = new MutationObserver(function(mutationsList) {
            let addedNodes = [];
            for (const mutation of mutationsList) {
                if (mutation.type === 'childList') {
                    mutation.addedNodes.forEach(node => {
                        if (node.classList && node.classList.contains('grid_item')) {
                            addedNodes.push(node);
                        }
                    });
                }
            }
            if (addedNodes.length > 0) {
                debouncedGetLocations();
            }
        });

        // Start observing the gridContainer for added nodes
        observer.observe(gridContainer, { childList: true });
        
        
        function getLocations() {
            var gridItems = document.getElementsByClassName("grid_item");
            var itemLocations = [];
            var itemNames = [];
            for (var i = 0; i < gridItems.length; i++) {
                var itemLocation = document.getElementsByClassName("item_location")[i].textContent.trim();
                var itemName = document.getElementsByClassName("item_name")[i].textContent.trim();
                itemLocations.push(itemLocation);
                itemNames.push(itemName);
            }
            
            for (let i = 0; i < itemLocations.length; ++i) {
                let itemName = itemNames[i];
                let itemLocation = itemLocations[i];
                
                geocoder.geocode({ 'address': itemLocations[i] }, function(results, status) {
                    if (status === 'OK') {
                        var marker = new google.maps.Marker({
                            map: map,
                            position: results[0].geometry.location
                        });
            
                        var infowindow = new google.maps.InfoWindow({
                            content: itemName + "<br>" + itemLocation
                        });
            
                        marker.addListener('click', function() {
                            infowindow.open(map, marker);
                        });
                    } else {
                        alert('Geocode was not successful for the following reason: ' + status);
                    }
                });
            }
            
        }
    </script>

    <div class="view_item_index" style="display:none"></div>
    
    <!-- Alicia view item user module  -->
    <div class="view_item_module">
        <div class="view_item_photo_module">
            <div class="view_item_photo"></div>
            <div id="photo_back_button"></div>
            <div id="photo_front_button"></div>
        </div>

        <!-- Space between -->

        <div class="view_item_line"></div>

        <div class="view_item_duration_module">
            <input type="text" class="view_item_duration_months" placeholder="Months">
            <input type="text" class="view_item_duration_weeks" placeholder="Weeks">
            <input type="text" class="view_item_duration_days" placeholder="Days">
            <input type="text" class="view_item_duration_hours" placeholder="Hours">
            <input type="text" class="view_item_duration_minutes" placeholder="Minutes">
        </div>
        <!-- Alicia addToCart -->
        <div class="view_item_cancel_add_module">
            <div class="view_item_quantity_module">
                <div class="view_item_quantity_deduct"> - </div>
                <div class="view_item_quantity_number"> 1 </div>
                <div class="view_item_quantity_add"> + </div>
            </div>
            <div class="view_item_add_to_cart_module"> Add to cart </div>
            <div class="view_item_close"> Close </div>
        </div>
    </div>

    <!-- Alicia basic information besides reviews -->
    <div class="view_user_profile">
        <%
            try {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

                Statement stmt = con.createStatement();

                String getUserInfoQuery = String.format("SELECT * FROM rentle.user WHERE user_id = %s", 1);
                ResultSet rs = stmt.executeQuery(getUserInfoQuery);
                rs.next();
                String fullname = rs.getString("first_name") + " " + rs.getString("last_name");
                String email = rs.getString("email");
                String number = rs.getString("phone_number");
                String pfp = rs.getString("profile_picture");
                String date = LocalDateTime.parse(rs.getString("creation_date").replace(" ","T")).format(DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM));

        %>
        <div class="view_user_profile_1">
            <img src="<%=pfp%>" alt="" class="profile_picture">
            <div class="view_user_profile_2_asterisk">
                <div class="view_user_profile_2">
                    <div class="view_user_profile_3">
                        <div class="email_icon"></div>
                        <div class="phone_number_icon"></div>
                    </div>
                    <div class="view_user_profile_4">
                        <div class="email"><%=email%></div>
                        <div class="phone_number"><%=number%></div>
                    </div>
                </div>
                <div class="view_user_profile_module">
                    <div class="view_user_profile_module_add_friend"></div>
                    <div class="view_user_profile_module_message">Message</div>
                    <div class="view_user_profile_module_see_rentals">Rentals</div>
                </div>
            </div>
        </div>
        <div class="user_full_name"><%=fullname%></div>
        <div class="member_date"> Member since <%=date%></div>
        <!-- <div class="current_location"> Currently at Santa Cruz, CA </div> -->
        <div class="view_user_profile_line"></div>
        <div class="renter_reviews_module">
            <div class="renter_reviews_name"> Renter reviews</div>
            <div class="renter_reviews"> 4.5 <i class="fas fa-star" id="renter_review_star_icon"></i></div>
        </div>
        <%
            } catch(SQLException e) {
                out.println("8");
            }
        %>
        <div class="renter_reviews_list_module">
            <div class="renter_reviews_list">
                <div class="renter_reviews_list_item">
                    <div class="renter_reviews_list_item_1">
                        <div class="renter_reviews_list_item_1_module">
                            <div class="renter_review_full_name"> Alicia Shi </div>
                            <div class="renter_review_stars"> 5.0 <i class="fas fa-star" id="renter_review_star_icon_1"></i></div>
                        </div>
                    </div>
                    <div class="renter_review_description"> Awesome experience with Phuc, keep his bike clean and everything well! Woohoo! </div>
                </div>

                <div class="renter_reviews_list_item">
                    <div class="renter_reviews_list_item_1">
                        <div class="renter_reviews_list_item_1_module">
                            <div class="renter_review_full_name"> Shashhank Seethula </div>
                            <div class="renter_review_stars"> 4.0 <i class="fas fa-star" id="renter_review_star_icon_1"></i></div>
                        </div>
                    </div>
                    <div class="renter_review_description"> Nice guy, a bit talkative. Still a good choice. </div>
                </div>
    
    
                <div class="renter_reviews_list_item">
                    <div class="renter_reviews_list_item_1">
                        <div class="renter_reviews_list_item_1_module">
                            <div class="renter_review_full_name"> Mike Wu </div>
                            <div class="renter_review_stars"> 4.5 <i class="fas fa-star" id="renter_review_star_icon_1"></i></div>
                        </div>
                    </div>
                    <div class="renter_review_description"> My CS157A student is now letting me rent one of his bikes! I love it! </div>
                </div>
            </div>
        </div>

        <div class="view_user_profile_line_1"></div>

        <div class="renting_reviews_module">
            <div class="renting_reviews_name"> Renting reviews</div>
            <div class="renting_reviews"> 4.3 <i class="fas fa-star" id="renting_review_star_icon"></i></div>
        </div>

        <div class="renting_reviews_list_module">
            <div class="renting_reviews_list">
                <div class="renting_reviews_list_item">
                    <div class="renting_reviews_list_item_1">
                        <div class="renting_reviews_list_item_1_module">
                            <div class="renting_review_full_name"> Lionel Messi </div>
                            <div class="renting_review_stars"> 5.0 <i class="fas fa-star" id="renting_review_star_icon_1"></i></div>
                        </div>
                    </div>
                    <div class="renting_review_description"> Fantastic visit to San Jose thanks to the help of this guy! Best referral to my homies in Miami! </div>
                </div>
            
                <div class="renting_reviews_list_item">
                    <div class="renting_reviews_list_item_1">
                        <div class="renting_reviews_list_item_1_module">
                            <div class="renting_review_full_name"> Mike Wu </div>
                            <div class="renting_review_stars"> 3.5 <i class="fas fa-star" id="renting_review_star_icon_1"></i></div>
                        </div>
                    </div>
                    <div class="renting_review_description"> Good talk with him, but at the end, he did not give me more Japanese food!</div>
                </div>
            </div>
        </div>
    </div>
    <div class="view_user_profile_close"></div>

    <script>
        var bool = 0;

        $('.view_item_description_see_more').click(function () {
            var $descriptionModule = $('.view_item_description_module');
            var $seeMoreButton = $('.view_item_description_see_more');
            var descriptionModuleHeight1, descriptionModuleHeight2;
            if (bool === 0) {
                descriptionModuleHeight1 = parseFloat($descriptionModule.css('height'));
                descriptionModuleHeight2 = parseFloat($descriptionModule.css('height')) * 2.5;
                $seeMoreButton.text("See less");
            }
            else {
                descriptionModuleHeight1 = parseFloat($descriptionModule.css('height'));
                descriptionModuleHeight2 = parseFloat($descriptionModule.css('height')) * 0.4;
                $seeMoreButton.text("See more");
            }

            console.log(descriptionModuleHeight1, descriptionModuleHeight2, bool);

            $descriptionModule.css('height', descriptionModuleHeight2 + 'px');
            bool = (bool + 1) % 2;
        });
        $('.view_item_quantity_deduct').click(function() {
            var value = parseInt($('.view_item_quantity_number').text(), 10);
            value = value - 1;
            value = Math.max(value, 1);
            $('.view_item_quantity_number').text(String(value));
        });
        $('.view_item_quantity_add').click(function() {
            var value = parseInt($('.view_item_quantity_number').text(), 10);
            value = value + 1;
            $('.view_item_quantity_number').text(String(value));
        });

        function checkDurationViewItem(x, y, z, t) {
            $(x)
                .on('input', function() {
                    var $this = $(this);
                    var content = $this.val().trim();

                    // Validate the current input
                    if (content !== "" && (isNaN(content) || content < y || content > z)) {
                        $this.css('border-bottom', '2px solid red');
                    } else {
                        $this.css('border-bottom', '');
                    }
                })
                .on('focusout', function() {
                    var $this = $(this);
                    var content = $this.val().trim();

                    if (/^\s*$/.test(content) || isNaN(content) || content < y || content > z) {
                        $this.val("");
                        $this.css('border-bottom', '');
                    } else {
                        if (content !== "" && !content.endsWith(t)) {
                            $this.val(content + t);
                        }
                    }
                })
                .on('focus', function() {
                    var $this = $(this);
                    var content = $this.val().trim();

                    if (content.endsWith(t)) {
                        var lengthOfT= t.length;
                        content = content.slice(0, -lengthOfT);
                        $this.val(content);
                    }
                });
        }
        checkDurationViewItem('.view_item_duration_months', 1, 11, ' months');
        checkDurationViewItem('.view_item_duration_weeks', 1, 3, ' weeks');
        checkDurationViewItem('.view_item_duration_days', 1, 6, ' days');
        checkDurationViewItem('.view_item_duration_hours', 1, 23, ' hours');
        checkDurationViewItem('.view_item_duration_minutes', 1, 59, ' minutes');
    </script>

     <script>
        function conditionCheckbox(x, y, z, t) {
            let count = 0;
            $(document).ready(function() {
                $(t).click(function() {
                    count++;
                    if (count === 1) {
                        $(x).css('transform', 'translateX(35px)');
                    }
                    if (count === 2) {
                        $(z).css('opacity', '1');
                        $(z).css('transform', 'translateX(35px)');
                        $(x).css('opacity', '0');
                        $(x).css('transform', 'translateX(0px)');
                    }
                    if (count === 3) {
                        $(z).css('opacity', '0');
                        $(z).css('transform', 'translateX(0px)');
                        $(x).css('opacity', '1');
                        $(x).css('transform', 'translateX(35px)');
                        count = 1;
                    }
                });
            });
        }

        conditionCheckbox('.condition_checkbox_excellent_square1','.condition_checkbox_excellent_icon','.condition_checkbox_excellent_square2', '.condition_checkbox_excellent');

        conditionCheckbox('.condition_checkbox_good_square1','.condition_checkbox_good_icon','.condition_checkbox_good_square2', '.condition_checkbox_good');

        conditionCheckbox('.condition_checkbox_fair_square1','.condition_checkbox_fair_icon','.condition_checkbox_fair_square2', '.condition_checkbox_fair');
    </script>

    <script>
        $(document).ready(function() {
            $('.duration_dropdown_arrow').click(function() {
                var currentCategoryDropdownRotation = $('.duration_dropdown_arrow').css('transform');
                if (currentCategoryDropdownRotation === 'matrix(-1, 0, 0, -1, 0, 0)') {
                    $('.duration_dropdown_arrow').css({
                        'transform': 'rotate(0deg)',
                        'color': 'black',
                        'top': '0px'
                    });
                    $('.duration-dropdown-module').css({
                        'font-size': '80%',
                        'border': '3px solid rgb(31, 93, 30)',
                        'color': 'black'
                    });
                }
                else {
                    $('.duration_dropdown_arrow').css({
                        'transform': 'rotate(180deg)',
                        'color': 'rgb(31, 93, 30)',
                        'top': '1.75px'
                    });
                    $('.duration-dropdown-module').css({
                        'font-size': '90%',
                        'border': '3px solid rgb(70, 169, 68)',
                        'color': 'green'
                    });
                }
                if ($('.duration-dropdown-content').css('display') === 'block') {
                    $('.duration-dropdown-content').css('display', 'none');
                }
                else {
                    $('.duration-dropdown-content').css('display', 'block');
                }
            });
        });

        $(document).mousedown(function(event) {
            if (!$(event.target).closest('.duration_dropdown_arrow, .duration-dropdown-content').length) {
                $('.duration_dropdown_arrow').css({
                    'transform': 'rotate(0deg)',
                    'color': 'black',
                    'top': '0px'
                });
                $('.duration-dropdown-module').css({
                    'font-size': '80%',
                    'border': '3px solid rgb(31, 93, 30)',
                    'color': 'black'
                });
                $('.duration-dropdown-content').css('display', 'none');
            }
        }); 

        $('.duration-dropdown-content li').click(function() {
            var selectedText = $(this).text();
            $(this).toggleClass('active');
            $('.duration-dropdown-content li').not(this).removeClass('active');
            $('.duration-dropdown-module').text(selectedText);
            $('.duration-dropdown-content').css('display', 'none');
            $('.duration-dropdown-module').css({
                'font-size': '80%',
                'border': '3px solid rgb(31, 93, 30)',
                'color': 'black'
            });
            $('.duration_dropdown_arrow').css({
                'transform': 'rotate(0deg)',
                'color': 'black',
                'top': '0px'
            });
        });
    </script>

    <script>
        function calculateSeconds() {
            var timeInSeconds = [2592000, 604800, 86400, 3600, 60];
            var total = 0;
            $('.view_item_duration_module input').each(function(index) {
                var $input = $(this);
                var value = parseFloat($input.val().split(" ")[0]);
                if (isNaN(value)) {
                    value = 0;
                }
                total += value * timeInSeconds[index];
            });
            return total;
        }

        function addToCart() {
            var currentItemId = $('.view_item_index').text().trim();
            var currentUserId = $('#user_id').text().trim();
            console.log(currentUserId);
            console.log(currentItemId);
            var duration = calculateSeconds();

            console.log(duration);
            var viewItemQuantity = document.getElementsByClassName('view_item_quantity_number')[0].textContent.trim();

            console.log(viewItemQuantity);
            var xhr = new XMLHttpRequest();

            xhr.open("GET", "addToCart.jsp?currentItemId=" + encodeURIComponent(currentItemId) +
                            "&currentUserId=" + encodeURIComponent(currentUserId) +
                            "&duration=" + encodeURIComponent(duration) +
                            "&viewItemQuantity=" + encodeURIComponent(viewItemQuantity), true);
                            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log("Success");
                } else {
                    console.log("Failed");
                }
            };
            xhr.send();
        }

        $('.view_item_add_to_cart_module').click(function() {
            addToCart();
            location.reload(true);
        });
    </script>


    <script>
        $(document).ready(function() {
            $("#photo_front_button").hover(
                function() {
                    $("#photo_front_button").css('box-shadow', '0 0 9px pink');
                    $(".view_item_photo").css('box-shadow', '0 0 9px pink');
                },
                function() {
                    $(".view_item_photo").hover(
                        function() {
                            $("#photo_front_button").css('box-shadow', '');
                            $(".view_item_photo").css('box-shadow', '0 0 9px pink');
                        },
                        function() {
                            $("#photo_front_button").css('box-shadow', '');
                            $(".view_item_photo").css('box-shadow', '');
                        }
                    );
                    $("#photo_front_button").css('box-shadow', '');
                    $(".view_item_photo").css('box-shadow', '');
                }
            );

            $("#photo_back_button").hover(
                function() {
                    $("#photo_back_button").css('box-shadow', '0 0 9px pink');
                    $(".view_item_photo").css('box-shadow', '0 0 9px pink');
                },
                function() {
                    $(".view_item_photo").hover(
                        function() {
                            $("#photo_back_button").css('box-shadow', '');
                            $(".view_item_photo").css('box-shadow', '0 0 9px pink');
                        },
                        function() {
                            $("#photo_back_button").css('box-shadow', '');
                            $(".view_item_photo").css('box-shadow', '');
                        }
                    );
                    $("#photo_back_button").css('box-shadow', '');
                    $(".view_item_photo").css('box-shadow', '');
                }
            );
        });
    </script>

    <script>
        $(document).ready(function() {
            $('#location_slider').on('input', function() {
                var value = $(this).val();
                $('.location_value').text(value + ' miles');
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            function formatTimeWithS(timeVar) {
                return (timeVar > 1 ? 's ': ' ');
            }

            function formatTime(seconds) {
                if (seconds <= 59) return seconds + ' second' + formatTimeWithS(seconds);
                if (60 <= seconds && seconds < 3600) {
                    var minutes = Math.floor(seconds/60);
                    var second = seconds - minutes * 60;
                    return minutes + ' minute' + formatTimeWithS(minutes) + (second != 0 ? (second + ' second' + formatTimeWithS(second)) : '');
                }
                if (3600 <= seconds && seconds < 86400) {
                    var hours = Math.floor(seconds/3600);
                    var minutes = Math.floor((seconds - hours * 3600)/60);
                    return hours + ' hour' + formatTimeWithS(hours) + (minutes > 0 ? minutes + ' minute' + formatTimeWithS(minutes) : '');
                }
                if (86400 <= seconds && seconds < 604800) {
                    var days = Math.floor(seconds/86400);
                    var hours = Math.floor((seconds - days * 86400)/3600);
                    return days + ' day' + formatTimeWithS(days) + (hours > 0 ? hours + ' hour' + formatTimeWithS(hours) : '');
                }
                if (604800 <= seconds && seconds < 2592000) {
                    var weeks = Math.floor(seconds/604800);
                    var days = Math.floor((seconds - days * 604800)/86400);
                    return weeks + ' week' + formatTimeWithS(weeks) + (days > 0 ? days + ' day' + formatTimeWithS(days) : '');
                }
                if (2592000 <= seconds && seconds < 31536000) {
                    var months = Math.floor(seconds/2592000);
                    var weeks = Math.floor((seconds - days * 2592000)/604800);
                    return months + ' month' + formatTimeWithS(months) + (weeks > 0 ? weeks + ' week' + formatTimeWithS(weeks) : '');
                }
            }

            $('.your_rentings_current_grid_item').each(function() {
                var divText = $(this).find('.your_rentings_current_grid_item_duration_name').text().trim();
                var seconds = parseFloat(divText);
                
                $(this).find('.your_rentings_current_grid_item_duration_name').text(formatTime(seconds));

                var $timeRemainingDiv = $(this).find('.your_rentings_current_grid_item_time_remaining_name');
                $timeRemainingDiv.text(formatTime(seconds));

                setInterval(function() {
                    if (seconds > 0) {
                        seconds--;
                        $timeRemainingDiv.text(formatTime(seconds));
                    } else {
                        clearInterval(interval);
                    }
                }, 1000);
            });

            $('.cart_item').each(function() {
                var text = $(this).find('.cart_item_duration').text().trim();
                var textToSeconds = parseFloat(text);
                $(this).find('.cart_item_duration').text(formatTime(textToSeconds));
            });


        });
    </script>

    <script>
        const colors = [
            "rgb(244, 199, 182)", "rgb(244, 220, 182)", "rgb(210, 234, 170)", "rgb(152, 211, 174)", "rgb(152, 208, 211)", 
            "rgb(132, 150, 189)", "rgb(134, 116, 166)", "rgb(148, 108, 154)", "rgb(176, 129, 131)", "rgb(172, 119, 135)"
        ];

        function getRandomColor() {
            const randomIndex = Math.floor(Math.random() * colors.length);
            return colors[randomIndex];
        
        }
        document.getElementById('add_items_features_input').addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                var inputValue = this.value.trim();
                if (inputValue) {
                    var featuresList = document.querySelector('.add_item_features_list');
                    var newFeature = document.createElement('div');
                    newFeature.className = 'add_item_features';
                    newFeature.textContent = inputValue;
                    var randomColor = getRandomColor();
                    newFeature.style.backgroundColor = randomColor;
                    newFeature.setAttribute('contenteditable', 'true');
                    featuresList.insertBefore(newFeature, document.querySelector('.add_item_features_plus_icon'));
                    this.value = ''; 
                }
            }
        });

        $('.add_items_features_icon').click(function() {
            var inputField = document.getElementById('add_items_features_input');
            var inputValue = inputField.value.trim(); 
            if (inputValue) {
                var featuresList = document.querySelector('.add_item_features_list');
                var newFeature = document.createElement('div');
                newFeature.className = 'add_item_features';

                var innerDiv = document.createElement('div');
                innerDiv.textContent = inputValue;
                innerDiv.setAttribute('contenteditable');

                var randomColor = getRandomColor();
                newFeature.style.backgroundColor = randomColor;

                newFeature.appendChild(innerDiv);

                featuresList.insertBefore(newFeature, document.querySelector('.add_item_features_plus_icon')); 
                inputField.value = '';
            }
        });

        $('.add_item_features_list').on('click', '.add_item_features', function() {
            $(this).css({
                'border': '2px solid gray',
                'box-shadow': '0 0 8px gray'
            });
        }).on('blur', '.add_item_features', function() {
            $(this).css({
                'border': '',
                'box-shadow': ''
            });
            $(this).blur();
        });

        // Ensure the element gets focus when clicked
        $('.add_item_features_list').on('focus', '.add_item_features', function() {
            $(this).css({
                'border': '2px solid gray',
                'box-shadow': '0 0 8px gray'
            });
        }).on('blur', '.add_item_features', function() {
            $(this).css({
                'border': '',
                'box-shadow': ''
            });
            $(this).blur();
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.add_item_features_plus_icon').click(function() {
                if ($('.add_items_features_type').css('display') === 'block') {
                    $('.add_items_features_type').css('display', 'none');
                }
                else {
                    $('.add_items_features_type').css('display', 'block');
                }
            });
        });

        $(document).click(function(event) {
            if (!$(event.target).closest('.add_item_features_plus_icon, .add_items_features_type').length) {
                $('.add_items_features_type').css('display', 'none');
            }
        });
    </script>

    <!-- if(box.text().trim().length == 0){
            box.blur().focus();
        } -->

    <script>
        $(document).ready(function() {
            $('.add_item_condition_dropdown_arrow').click(function() {
                if ($('.add_item_condition_dropdown_content').css('display') === 'block') {
                    $('.add_item_condition_dropdown_content').css('display', 'none');
                }
                else {
                    $('.add_item_condition_dropdown_content').css('display', 'block');
                }
            });

            $('.add_item_category_dropdown_arrow').click(function() {
                if ($('.add_item_category_dropdown_content').css('display') === 'block') {
                    $('.add_item_category_dropdown_content').css('display', 'none');
                }
                else {
                    $('.add_item_category_dropdown_content').css('display', 'block');
                }
            });
        });

        $(document).click(function(event) {
            if (!$(event.target).closest('.add_item_category_dropdown_arrow, .add_item_category_dropdown_content').length) {
                $('.add_item_category_dropdown_content').css('display', 'none');
            }
        });

        $(document).click(function(event) {
            if (!$(event.target).closest('.add_item_condition_dropdown_arrow, .add_item_condition_dropdown_content').length) {
                $('.add_item_condition_dropdown_content').css('display', 'none');
            }
        });
    </script>

    <script>
        const inputImg = document.getElementById('file-upload');
        const addPhotosGrid = document.getElementById('add_photos_grid');

        function getImg(event) {
            const files = event.target.files;
            for (let i = 0; i < files.length; i++) {
                const file = files[i];

                if (file && file.type.startsWith('image/')) {
                    const url = window.URL.createObjectURL(file);

                    const imageDiv = document.createElement('div');
                    imageDiv.className = 'grid-item';

                    const img = document.createElement('img');
                    img.src = url;
                    imageDiv.appendChild(img);

                    const deleteButton = document.createElement('div');
                    deleteButton.className = 'delete-button';
                    deleteButton.addEventListener('click', function() {
                        imageDiv.remove();
                    });

                    imageDiv.appendChild(deleteButton);

                    addPhotosGrid.insertBefore(imageDiv, addPhotosGrid.querySelector('.add_photo_module'));
                } else {
                    alert('Please select only image files.');
                }
            }
        }
        inputImg?.addEventListener('change', getImg);

    </script>

    <script>
        $(document).ready(function() {
            $('.sort_module').click(function() {
                var currentRotation = $('.sort_dropdown_trigger').css('transform');
                if (currentRotation === 'matrix(-1, 0, 0, -1, 0, 0)') {
                    $('.sort_dropdown_trigger').css({
                        'transform': 'rotate(0deg)',
                        'color': 'black'
                    });
                    $('.sort_list').css('display', 'none');
                    $('.sort_module').css('background', 'rgb(199, 199, 235)');
                    $('.sort_text').css({
                        'font-size': '15px',
                        'color': 'black'
                    });
                } else {
                    $('.sort_dropdown_trigger').css({
                        'transform': 'rotate(180deg)',
                        'color': 'white'
                    });
                    $('.sort_list').css('display', 'block');
                    $('.sort_module').css('background', 'rgb(81, 81, 145)');
                    $('.sort_text').css({
                        'font-size': '16px',
                        'color': 'white'
                    });
                    $('.sort_text').css({
                        'font-size': '16px',
                        'color': 'white'
                    });
                }
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.add_item').click(function() {
                if ($('.add_item_module').css('display') === 'block') {
                    $('.add_item_module').css('display', 'none');
                    $('.blur_background').css('display', 'none');
                } else {
                    $('.add_item_module').css('display', 'block');
                    $('.blur_background').css('display', 'block');
                }
            });

            $('.add_item_cancel').click(function() {
                $('.add_item_module').css('display', 'none');
                $('.blur_background').css('display', 'none');
            });

            $('.add_item_add').click(function() {
                var currentUserId = $('#user_id').text().trim();
                if (isNaN(currentUserId)) {
                    $('.add_item_module').css('display', 'none');
                    $('.blur_background').css('display', 'none');
                    if ($('#login-module').css('display') === 'none') {
                        console.log(true);
                        $('#login-module').css('display', 'block');
                        $('.signup_login_button').addClass('active');
                    }
                }
                else {
                    addItem();
                    location.reload(true);
                }
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.grid_container').on('click', '.grid_item', function() {
                $('.view_item_index').empty();
                $('.view_item_information_module').children().empty();
                $('.view_item_index').text($(this).index() + 1);
                viewItem();

                setTimeout(function() {
                    if ($('.view_item_module').css('display') === 'block') {
                        $('.view_item_module').css('display', 'none');
                        $('.blur_background').css('display', 'none');
                    }
                    else {
                        $('.view_item_module').css('display', 'block');
                        $('.blur_background').css('display', 'block');
                    }

                    let photos = $('.view_item_store_information').attr('data-photos');
                    photos = JSON.parse(photos);

                    let currentImageIndex = 0;

                    function updateImage() {
                        var testPhotoDiv = $('.view_item_photo');
                        testPhotoDiv.empty();

                        // Create a new image element
                        var imgElement = $('<img>');
                        imgElement.attr('src', photos[currentImageIndex].replace("./Images/", "images/"));

                        // Append the image to the div
                        testPhotoDiv.append(imgElement);

                    }

                    $('#photo_back_button').click(function () {
                        if (currentImageIndex === 0) {
                            currentImageIndex = photos.length - 1;
                        }
                        else {
                            currentImageIndex = currentImageIndex - 1;
                        }
                        updateImage();
                    });

                    $('#photo_front_button').click(function () {
                        if (currentImageIndex === photos.length - 1) {
                            currentImageIndex = 0;
                        }
                        else {
                            currentImageIndex = currentImageIndex + 1;
                        }
                        updateImage();
                    });
                    updateImage();
                }, 100);
            });

            $('.view_item_close, .view_item_add_to_cart_module').click(function() {
                $('.view_item_module').css('display', 'none');
                $('.blur_background').css('display', 'none');
                $('.view_user_profile').css('display', 'none');
                $('.view_user_profile_close').css('display', 'none');
            });

            $('.view_user_profile_close').click(function() {
                $('.view_user_profile').css('display', 'none');
                $('.view_user_profile_close').css('display', 'none');
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.view_item_view_user_profile').text('SEE INFO');
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.view_user_profile_module_message').click(function() {
                $('.view_item_module').css('display', 'none');
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.view_user_profile').css('display', 'none');
                $('.view_user_profile_close').css('display', 'none');
                $('.view_item_view_user_profile').text('SEE INFO');
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.blur_background').css('display', 'none');
                $('#messages_view').css('display', 'block');
            });

            $('.view_user_profile_module_add_friend').click(function() {
                $('.view_item_module').css('display', 'none');
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.view_user_profile').css('display', 'none');
                $('.view_user_profile_close').css('display', 'none');
                $('.view_item_view_user_profile').text('SEE INFO');
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.blur_background').css('display', 'none');
                $('#friends_view').css('display', 'block');
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.view_item_view_user_profile, .view_item_user_name').click(function() {
                if ($('.view_user_profile').css('display') === 'none') {
                    $('.view_user_profile').css('display', 'block');
                    $('.view_user_profile_close').css('display', 'flex');
                    $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(-14vw)');
                    $('.view_item_view_user_profile').text('CLOSE');
                }
                else {
                    if ($('.view_user_profile').css('display') === 'block') {
                        $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                    }
                    $('.view_user_profile').css('display', 'none');
                    $('.view_user_profile_close').css('display', 'none');
                    $('.view_item_view_user_profile').text('SEE INFO');
                }
            });
        });

        $(document).ready(function() {
            $('.view_item_close').click(function() {
                $('.view_item_module').css('transform', 'translate(-50%, -50%) translateX(0)');
                $('.view_user_profile').css('display', 'none');
                $('.view_user_profile_close').css('display', 'none');
                $('.view_item_view_user_profile').text('SEE INFO');
            });
        });

        $('.blur_background').click(function(event) {
            $('.view_item_module').css('display', 'none');
            $('.view_user_profile').css('display', 'none');
            $('.add_item_module').css('display', 'none');
            $('.blur_background').css('display', 'none');
        });

    </script>

    <script>
        $(document).ready(function() {
            $('.shopping_icon').click(function() {
                if ($('.cart_module').css('display') === 'block' || $('.cart_payment_module').css('display') === 'block') {
                    $('.cart_module').css('display', 'none');
                    $('.cart_payment_module').css('display', 'none');
                    $('.shopping_icon').css('color','rgba(29, 20, 20, 0.836)');
                    $('.shopping_icon').css('font-size','25px');
                }
                else {
                    $('.cart_module').css('display', 'block');
                    $('.shopping_icon').css('color','rgb(117, 183, 196)');
                    $('.shopping_icon').css('font-size','26px');
                }
            });

            $(document).click(function(event) {
                if (!$(event.target).closest('.cart_module, .cart_payment_module, .shopping_icon').length) {
                    $('.cart_module').css('display', 'none');
                    $('.cart_payment_module').css('display', 'none');
                    $('.shopping_icon').css('color', 'rgba(29, 20, 20, 0.836)');
                    $('.shopping_icon').css('font-size', '25px');
                }
            });

            $('.rent_now').click(function() {
                if ($('.cart_payment_module').css('display') === 'none') {
                    $('.cart_payment_module').css('display', 'block');
                    $('.cart_module').css('display', 'none');
                }
            });
            $('.cart_payment_back').click(function() {
                if ($('.cart_module').css('display') === 'none') {
                    $('.cart_payment_module').css('display', 'none');
                    $('.cart_module').css('display', 'block');
                }
            });
            $('.cart_payment_submit').click(function() {
                if ($('.cart_module').css('display') === 'block' || $('.cart_payment_module').css('display') === 'block') {
                    $('.cart_module').css('display', 'none');
                    $('.cart_payment_module').css('display', 'none');
                }
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('#your_rentals').click(function() {
                if ($('#your_rentals_view').css('display') === 'none') {
                    $('#your_rentals_view').css('display', 'block');
                    $('#your_rentings_view, #messages_view, #friends_view').css('display', 'none');
                    $('.your_rentings_icon, .messages_icon, .friends_icon').css({
                        'color': '#0f0404',
                        'font-size': '25px'
                    });
                    $('.your_rentings_text, .messages_text, .friends_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                    $('.your_rentals_icon').css({
                        'color': 'rgba(26, 121, 150, 0.901)',
                        'font-size': '30px'
                    });
                    $('.your_rentals_text').css({
                        'color': 'rgba(26, 121, 150, 0.901)',
                        'font-size': '19.5px'
                    });
                } else {
                    $('#your_rentals_view').css('display', 'none');
                    $('.your_rentals_icon').css({
                        'color': '#0f0404',
                        'font-size': '25px'
                    });
                    $('.your_rentals_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                }
            });

            $('#past_rentals').click(function() {
                $('#your_rentals_past_grid_container').css('display', 'grid');
                $('#your_rentals_current_grid_container').css('display', 'none');
                $('#past_rentals').css({
                    'border': '3px solid rgb(13, 0, 255)',
                    'background': 'rgba(169, 194, 247, 0.46)',
                    'color': 'rgb(88, 83, 83)'
                });
                $('#current_rentals').css({
                    'border': '3px solid rgb(33, 95, 95)',
                    'background': 'rgba(123, 241, 241, 0.429)',
                    'color': 'rgb(5, 23, 23)'
                });
            });

            $('#current_rentals').click(function() {
                $('#your_rentals_current_grid_container').css('display', 'grid');
                $('#your_rentals_past_grid_container').css('display', 'none');
                $('#current_rentals').css({
                    'border': '3px solid rgb(13, 0, 255)',
                    'background': 'rgba(169, 194, 247, 0.46)',
                    'color': 'rgb(88, 83, 83)'
                });
                $('#past_rentals').css({
                    'border': '3px solid rgb(33, 95, 95)',
                    'background': 'rgba(123, 241, 241, 0.429)',
                    'color': 'rgb(5, 23, 23)'
                });
            });
        });

        $(document).ready(function() {
            $('#your_rentings').click(function() {
                if ($('#your_rentings_view').css('display') === 'none') {
                    $('#your_rentings_view').css('display', 'block');
                    $('#your_rentals_view, #messages_view, #friends_view').css('display', 'none');
                    $('.your_rentals_icon, .messages_icon, .friends_icon').css({
                        'color': '#0f0404',
                        'font-size': '25px'
                    });
                    $('.your_rentals_text, .messages_text, .friends_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                    $('.your_rentings_icon').css({
                        'color': 'rgba(193, 75, 12, 0.901)',
                        'font-size': '30px'
                    });
                    $('.your_rentings_text').css({
                        'color': 'rgba(193, 75, 12, 0.901)',
                        'font-size': '19.5px'
                    });
                } else {
                    $('#your_rentings_view').css('display', 'none');
                    $('.your_rentings_icon').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '25px'
                    });
                    $('.your_rentings_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                }
            });

            $('#past_rentings').click(function() {
                $('#your_rentings_past_grid_container').css('display', 'grid');
                $('#your_rentings_current_grid_container').css('display', 'none');
                $('#past_rentings').css({
                    'border': '3px solid rgb(241, 109, 86)',
                    'background': 'rgba(243, 219, 186, 0.46)',
                    'color': 'rgb(88, 83, 83)'
                });
                $('#current_rentings').css({
                    'border': '3px solid rgb(116, 76, 40)',
                    'background': 'rgba(215, 181, 137, 0.429)',
                    'color': 'rgb(5, 23, 23)'
                });
            });

            $('#current_rentings').click(function() {
                $('#your_rentings_current_grid_container').css('display', 'grid');
                $('#your_rentings_past_grid_container').css('display', 'none');
                $('#past_rentings').css({
                    'border': '3px solid rgb(116, 76, 40)',
                    'background': 'rgba(215, 181, 137, 0.429)',
                    'color': 'rgb(5, 23, 23)'
                });
                $('#current_rentings').css({
                    'border': '3px solid rgb(241, 109, 86)',
                    'background': 'rgba(243, 219, 186, 0.46)',
                    'color': 'rgb(88, 83, 83)'
                });
            });
        });

        $(document).ready(function() {
            $('#messages').click(function() {
                if ($('#messages_view').css('display') === 'none') {
                    $('#messages_view').css('display', 'block');
                    $('#your_rentals_view, #your_rentings_view, #friends_view').css('display', 'none');
                    $('.your_rentals_icon, .your_rentings_icon, .friends_icon').css({
                        'color': '#0f0404',
                        'font-size': '25px'
                    });
                    $('.your_rentals_text, .your_rentings_text, .friends_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                    $('.messages_icon').css({
                        'color': 'rgba(120, 16, 145, 0.901)',
                        'font-size': '30px'
                    });
                    $('.messages_text').css({
                        'color': 'rgba(120, 16, 145, 0.901)',
                        'font-size': '19.5px'
                    });
                } else {
                    $('#messages_view').css('display', 'none');
                    $('.messages_icon').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '25px'
                    });
                    $('.messages_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                }
                reloadDataGroup();
                reloaddata();
            });
        });

        $(document).ready(function() {
            $('#friends').click(function() {
                if ($('#friends_view').css('display') === 'none') {
                    $('#friends_view').css('display', 'block');
                    $('#your_rentals_view, #your_rentings_view, #messages_view').css('display', 'none');
                    $('.your_rentals_icon, .your_rentings_icon, .messages_icon').css({
                        'color': '#0f0404',
                        'font-size': '25px'
                    });
                    $('.your_rentals_text, .your_rentings_text, .messages_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                    $('#messages_view').css('display', 'none');
                    $('.friends_icon').css({
                        'color': 'rgba(163, 10, 10, 0.901)',
                        'font-size': '30px'
                    });
                    $('.friends_text').css({
                        'color': 'rgba(163, 10, 10, 0.901)',
                        'font-size': '19.5px'
                    });
                } else {
                    $('#friends_view').css('display', 'none');
                    $('.friends_icon').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '25px'
                    });
                    $('.friends_text').css({
                        'color': 'rgba(6, 14, 19, 0.988)',
                        'font-size': '17.5px'
                    });
                }
            });
        });
    </script>

    <script>
        var wrapper = document.getElementById("wrapper");
        var rectangle_center_component = document.getElementById("rectangle_center_component");
        var right_bar = document.getElementById("rightbar");
        handleDrag(wrapper, rectangle_center_component, right_bar);
    </script>

    <script>
        $(document).ready(function() {
            $('.category_dropdown_arrow').click(function() {
                var currentDropdownRotation = $('.category_dropdown_arrow').css('transform');
                if (currentDropdownRotation === 'matrix(-1, 0, 0, -1, 0, 0)') {
                    $('.category_module').css('border-bottom', '2px solid black');
                    $('.category_icon_background').css('background', 'black');
                    $('.category_icon').css('color', '#f8f5f5');
                    $('.category_dropdown_arrow').css({
                        'color': '#100f0f',
                        'font-size': '38px'
                    });
                    $('.category_text').css({
                        'color':'black',
                        'font-size':'17.5px'
                    });
                    $('.category_dropdown_arrow').css('transform','rotate(0deg)');
                }
                else {
                    $('.category_module').css('border-bottom', '2px solid rgb(68, 195, 72)');
                    $('.category_icon_background').css('background', 'rgb(68, 195, 72)');
                    $('.category_icon').css('color', 'rgb(4, 18, 68)');
                    $('.category_dropdown_arrow').css({
                        'color': 'rgb(149, 234, 152)',
                        'font-size': '45px'
                    });
                    $('.category_text').css({
                        'color':'rgb(86, 177, 99)',
                        'font-size':'19px'
                    });
                    $('.category_dropdown_arrow').css('transform','rotate(180deg)');
                }
                if ($('.category_list').css('display') === 'none') {
                    $('.category_list').css('display', 'block');
                }
                else {
                    $('.category_list').css('display', 'none');
                }
            });

            $('.category-dropdown-content li').click(function() {
                $(this).toggleClass('active');
                $('.category-dropdown-content li').not(this).removeClass('active');
            });

            $('.features_dropdown_arrow').click(function() {
                var currentDropdownRotation = $('.features_dropdown_arrow').css('transform');
                if (currentDropdownRotation === 'matrix(-1, 0, 0, -1, 0, 0)') {
                    $('.features_module').css('border-bottom', '2px solid black');
                    $('.features_icon_background').css('background', 'black');
                    $('.features_icon').css('color', '#f8f5f5');
                    $('.features_dropdown_arrow').css({
                        'color': '#100f0f',
                        'font-size': '38px'
                    });
                    $('.features_text').css({
                        'color':'black',
                        'font-size':'17.5px'
                    });
                $('.features_dropdown_arrow').css('transform','rotate(0deg)');
                }
                else {
                    $('.features_module').css('border-bottom', '2px solid rgb(171, 54, 180)');
                    $('.features_icon_background').css('background', 'rgb(171, 54, 180)');
                    $('.features_icon').css('color', 'rgb(235, 237, 246)');
                    $('.features_dropdown_arrow').css({
                        'color': 'rgb(171, 54, 180)',
                        'font-size': '45px'
                    });
                    $('.features_text').css({
                        'color':'rgb(171, 54, 180)',
                        'font-size':'19px'
                    });
                    $('.features_dropdown_arrow').css('transform','rotate(180deg)');
                }
                if ($('.features_list').css('display') === 'none') {
                    $('.features_list').css('display', 'block');
                }
                else {
                    $('.features_list').css('display', 'none');
                }
            });

            $('.features-dropdown-content li').click(function() {
                $(this).toggleClass('active');
                $('.features-dropdown-content li').not(this).removeClass('active');
            });
        });

    </script>

    <script>
        $(document).ready(function() {
            $('.signup_login_button').click(function() {
                var userId = $('#user_id').text().trim();
                console.log("User ID: ", userId); // Debugging info

                if (isNaN(userId) || userId === "") {
                    console.log("Not logged in or invalid user ID"); // Debugging info
                    $('#loggedin_notification_component').css('display', 'none');
                    if ($('#login-module').css('display') === 'block') {
                        $('#login-module').css('display', 'none');
                        $('.signup_login_button').removeClass('active');
                    } else {
                        $('#login-module').css('display', 'block');
                        $('.signup_login_button').addClass('active');
                    }
                } else {
                    console.log("Logged in with user ID: ", userId); // Debugging info
                    $('#login-module').css('display', 'none');
                    if ($('#loggedin_notification_component').css('display') === 'none') {
                        $('#loggedin_notification_component').css('display', 'block');
                    } else {
                        $('#loggedin_notification_component').css('display', 'none');
                    }
                }
            });

            // if ($('#login-module').css('display') === 'block') {
            //     $(document).click(function(event) {
            //         if (!$(event.target).closest('.signup_login_button, #login-module').length) {
            //             $('#login-module').css('display', 'none');
            //             $('.signup_login_button').removeClass('active');
            //         }
            //     });
            // }

        });

    </script>


</body>
</html>
