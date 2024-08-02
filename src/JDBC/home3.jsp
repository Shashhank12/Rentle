<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Rentle - CS157A Project</title>
    <link rel="stylesheet" href="home.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <%
        String userID = "0";
        try {
            if (session.getAttribute("userID") != null) {
                userID = session.getAttribute("userID").toString();
            }
        } catch (IllegalStateException e) {
            out.println("IllegalStateException caught: " + e.getMessage());
        }
    %>
    <%
        String db = "rentle";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "Hello1234!"; //enter your password
    %>
    <script src="Homepage.js"></script>
    <script src="jquery-3.7.1.min.js"></script>
</head>
<body style="overflow-x: hidden;">
    <div class="blur_background"></div>
    <div id="map"></div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBFt-lS9JjEAzSssSrhYvAgzFMnmasayH0"></script>
    <script>
        function initMap() {
            // Create a map object and specify the DOM element for display.
            var map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 37.337, lng: -121.881},
                zoom: 16
            });
        }
    </script>



    <div class="leftbar">
        <div class="location_search_module">
            <div class="location_search_module_1">
                <input type="text" id="location_search" name="searchbox" placeholder="Address, ZIP Code, ...">
                <div class="search_icon"></div>
            </div>
            <div class="icon_circle">
                <div class="icon"></div>
            </div>
        </div>
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
            <div class="searchrent_icon"></div>
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
                <input type="range" min="0" max="100" value="5" step="5" id="location_slider">
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

    <div class="homepage_bar">
        <img src="image2.png" alt = "" class="logo">
        <div class="shopping_icon"></div>
        <div tabindex="0" id="signup_container">
            <div class="signup_login_button">
                <%
                    if (userID.equals("0")) {
                %>
                <div class="signup_login_text"> Signup / login</div>
                <% 
                    } else {
                %>
                <div class="signup_login_text">Welcome, <%=userID%>!</div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <div class="cart_module">
        <%
        int total = 0;
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

            Statement stmt = con.createStatement();

            String getCartQuery = String.format("SELECT item_id, name, quantity, duration, price_per_hour, price_per_day, price_per_week, price_per_month FROM cart, items, rentsfor, prices WHERE cart.ItemID = items.item_id AND UserID=%s AND cart.ItemID = rentsfor.ItemID AND prices.prices_id = rentsfor.ItemID;",userID);
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
            out.println("SQLException caught: " + e.getMessage());
        }
    %>

        <div class="cart_module_line"></div>
        <div class="cart_total_module">
            <div class="cart_total_text"> Total </div>
            <div class="cart_total_price"> $49.5 </div>
        </div>
        <div class="rent_now"> Rent now </div>
    </div>

    <div class="cart_payment_module">
        <input type="text" id="card_full_name" placeholder="Full Name">
        <input type="text" id="credit_card_number" placeholder="Credit Card Number">
        <input type="text" class="card_expiration_date" placeholder="MM/YY">
        <input type="text" id="card_cvv" placeholder="CVV">
        <div class="cart_payment_back"> Back </div>
        <div class="cart_payment_submit"> Submit </div>
    </div>

    <div id="login-module">
        <%
            if (userID.equals("0")) {
            %>
            <form id="login-form">
            <div class="error_module"> Incorrect email/password </div>
            <div class="username"> Email </div>
            <input type="text" id="username" name="searchbox" placeholder="Email, username, or phone number">
                <%
                    String myEmail = (String)request.getParameter("searchbox");
                    Boolean emailInvalid = false;
                    if (request.getParameter("submit") != null) {
                        try {
                            java.sql.Connection con;
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

                            Statement stmt = con.createStatement();

                            String emailQuery = String.format("SELECT COUNT(email) FROM user WHERE email = '%s';", myEmail);
                            ResultSet rs = stmt.executeQuery(emailQuery);
                            rs.next();
                            if (rs.getInt(1) == 0) {
                                emailInvalid = true;
                                %>
                                <script>
                                    $(document).ready(function () {
                                        $('.error_module').css('display', 'block');
                                        $('#login-module').css({
                                            'height': '29%',
                                            'display': 'block'
                                        });
                                    });
                                </script>
                                <%
                            }
                            
                            stmt.close();
                            con.close();
                        } catch(SQLException e) {
                            out.println("SQLException caught: " + e.getMessage());
                        }
                    }
                %>
            <div class="password"> Password </div>
            <input type="password" id="password" name="searchbox2" placeholder="">
                <%
                    String myPassword = (String)request.getParameter("searchbox2");
                    if (request.getParameter("submit") != null) {
                        try {
                            java.sql.Connection con;
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);

                            Statement stmt = con.createStatement();

                            String passwordQuery = String.format("SELECT user_id FROM user WHERE email='%s' AND password='%s' ORDER BY user_id DESC;", myEmail, myPassword);
                            // out.println(passwordQuery);
                            ResultSet rs = stmt.executeQuery(passwordQuery);
                            rs.next();

                            if (rs.getInt("user_id") > 0) {
                                String userID2 = String.valueOf(rs.getInt("user_id"));
                                session.setAttribute("userID", userID2);
                                rs.close();
                                String redirectURL = "http://localhost:8080/home2.jsp";
                                response.sendRedirect(redirectURL);
                            } else {
                            %>
                                <script>
                                    $(document).ready(function () {
                                        $('.error_module').css('display', 'block');
                                        $('#login-module').css({
                                            'height': '29%',
                                            'display': 'block'
                                        });
                                    });
                                </script>
                            <%
                            }
                            rs.close();
                            stmt.close();
                            con.close();
                        } catch(SQLException e) {
                            // out.println("SQLException caught: " + e.getMessage());
                        }
                    }
                %>
            <div id="login-button-module">
                <div class="login_button_background"></div>
                <input class="login_text" type="submit" value="Login" name="submit" id="submit-login-button">
            </div>
                <div id="signup_notification_component">
                    <div class="not_a_member_text"> Not a member? </div>
                    <a href="/sign-up.jsp"><div class="signup_hyperlink"> Sign up</div></a>
                </div>
            </form>
        <%
            } else {
        %>
            <div id="loggedin_notification_component">
                <form id="loggedin_notification_form">
                    <div class="view-profile-button">Profile</div>
                    <input type="submit" value="Log out" name="logout">
                    <%
                        if (request.getParameter("logout") != null) {
                            session.setAttribute("userID", "0");
                        }
                    %>
                </form>
            </div>
        <%
            }
        %>
        </div>
    </div>

    <script>
        function login() {
            var uname = document.getElementById('username');
            var pw = document.getElementById('password');
            if (uname.value == '' || pw.value == '') {
                alert('Please login to continue.');
                return false;
            }

            var xmlhttp;
            if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else { // code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp.open("POST", "chat?uname=" + uname.value + "&pw=" + pw.value, true);

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText.indexOf('Incorrect') !== -1) {
                        console.log("False");
                    } else {
                        console.log("True");
                        var name = responseText; // Assume the responseText is the name
                        document.getElementsByClassName('signup_login_text')[0].textContent = "Welcome, " + name;
                    }
                }
            }
            xmlhttp.send(null);
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

        <div class="grid_container">
            <div class="grid_item">
                <img src="image3.png" alt = "" class="item_image">
                <div class="grid_item_module_1">
                    <div class="grid_item_module_2">
                        <div class="item_name"> Bicycle for rent! </div>
                        <div class="item_module_1">
                            <div class="item_category"> Bike - </div>
                            <div class="item_feature"> Multiple gears </div>
                        </div>
                        <div class="item_location"> San Jose, CA </div>
                    </div>
                    <div class="item_price"> $15 </div>
                </div>
            </div>

            <div class="grid_item">
                <img src="image4.png" alt = "" class="item_image">
                <div class="grid_item_module_1">
                    <div class="grid_item_module_2">
                        <div class="item_name"> Bicycle for rent! </div>
                        <div class="item_module_1">
                            <div class="item_category"> Bike - </div>
                            <div class="item_feature"> Multiple gears </div>
                        </div>
                        <div class="item_location"> San Jose, CA </div>
                    </div>
                    <div class="item_price"> $15 </div>
                </div>
            </div>
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

    <div id="your_rentings_view">
        <div id="your_rentings_top_component">
            <input type="text" id="rentings_search" name="searchbox" placeholder="Title, category, location, date, ...">
            <div id="past_rentings"> Past</div>
            <div id="current_rentings"> Current</div>
        </div>
    
        <div id="your_rentings_past_grid_container">
            <div class="your_rentings_past_grid_item">  
                <img src="image5.png" alt = "" class="your_rentings_past_grid_item_image">
                <div class="your_rentings_past_module">
                    <div class="your_rentings_past_grid_item_title"> Gotrax Scooter Rent $1/hour </div>
                    <div class="your_rentings_past_category_module">
                        <div class="your_rentings_past_grid_item_category"> Category: </div>
                        <div class="your_rentings_past_grid_item_category_name"> Scooter </div>
                    </div>
                    <div class="your_rentings_past_features_module">
                        <div class="your_rentings_past_grid_item_features"> Features: </div>
                        <div class="your_rentings_past_grid_item_features_name"> Speakers, </div>
                        <div class="your_rentings_past_grid_item_features_name"> Auto-stop </div>
                    </div>
                    <div class="your_rentings_past_location_module">
                        <div class="your_rentings_past_grid_item_location"> Location: </div>
                        <div class="your_rentings_past_grid_item_location_name"> Hayward, CA </div>
                    </div>
                    <div class="your_rentings_past_date_module">
                        <div class="your_rentings_past_grid_item_date"> Date completed: </div>
                        <div class="your_rentings_past_grid_item_date_name"> July 21st, 2024 </div>
                    </div>
                    <div class="your_rentings_past_duration_module">
                        <div class="your_rentings_past_grid_item_duration"> Duration: </div>
                        <div class="your_rentings_past_grid_item_duration_name"> 1 hours </div>
                    </div>
                    <div class="your_rentings_past_price_module">
                        <div class="your_rentings_past_grid_item_price"> Price: </div>
                        <div class="your_rentings_past_grid_item_price_name"> $12.5 </div>
                    </div>
                </div>
            </div>
        </div>
    
        <div id="your_rentings_current_grid_container">
            <div class="your_rentings_current_grid_item">  
                <img src="image6.png" alt = "" class="your_rentings_current_grid_item_image">
                <div class="your_rentings_current_module">
                    <div class="your_rentings_current_grid_item_title"> Yarsca 24in Beach Cruiser Bike! </div>
                    <div class="your_rentings_current_category_module">
                        <div class="your_rentings_current_grid_item_category"> Category: </div>
                        <div class="your_rentings_current_grid_item_category_name"> Bike </div>
                    </div>
                    <div class="your_rentings_current_features_module">
                        <div class="your_rentings_current_grid_item_features"> Features: </div>
                        <div class="your_rentings_current_grid_item_features_name"> Speakers, </div>
                        <div class="your_rentings_current_grid_item_features_name"> Auto-stop </div>
                    </div>
                    <div class="your_rentings_current_location_module">
                        <div class="your_rentings_current_grid_item_location"> Location: </div>
                        <div class="your_rentings_current_grid_item_location_name"> Hayward, CA </div>
                    </div>
                    <div class="your_rentings_current_date_module">
                        <div class="your_rentings_current_grid_item_date"> Date: </div>
                        <div class="your_rentings_current_grid_item_date_name"> July 22th, 2024 </div>
                    </div>
                    <div class="your_rentings_current_duration_module">
                        <div class="your_rentings_current_grid_item_duration"> Duration: </div>
                        <div class="your_rentings_current_grid_item_duration_name"> 12600 </div>
                    </div>
                    <div class="your_rentings_current_price_module">
                        <div class="your_rentings_current_grid_item_price"> Price: </div>
                        <div class="your_rentings_current_grid_item_price_name"> $14 </div>
                    </div>
                </div>
                 <div class="your_rentings_current_time_remaining_module">
                    <div class="your_rentings_current_grid_item_time_remaining"> Time remaining </div>
                    <div class="your_rentings_current_grid_item_time_remaining_name"></div>
                </div>
            </div>

        </div>
    </div>

    
    <div id="messages_view">
        <div class="your_messages_text"> Messages </div>
        <input type="text" id="people_search" name="searchbox" placeholder="Who are you finding?">
        <div id="people_messages_grid">
            <div class="people_messages_item">
                <img src="profilepic1.png" alt = "" class="people_messages_profile_pic">
                <div class="people_messages_module">
                    <div class="people_messages_name"> Shiba Inu </div>
                    <div class="people_messages_content"> I need a bike to go to space </div>
                </div>
            </div>
        </div>
        <div class="messages_vertical_bar"></div>
    </div>


    <div id="friends_view"></div>

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
                        <input type="text" id="item_price_input_address" placeholder="Price per hour">
                        <input type="text" id="item_price_input_city" placeholder="Price per day">
                        <input type="text" id="item_price_input_state" placeholder="Price per week">
                        <input type="text" id="item_price_input_zip_code" placeholder="Price per month">
                    </div>
                </div>
            </div>
        </div>

        <div class="add_item_cancel_add_module">
            <div class="add_item_cancel"> Cancel </div>
            <div class="add_item_add"> Add </div>
        </div>
    </div>


    <div class="view_item_module" id="view_item_module" name="1">
        <%
            // TODO: POPULATE ALL OF THIS USING THE SEARCH RESULTS
            // for now, i have hardcoded the id in here
            int id = 1;
        %>
        <div class="view_item_photo_module">
            <div class="view_item_photo"></div>
            <div id="photo_back_button"></div>
            <div id="photo_front_button"></div>
        </div>
        <div class="view_item_information_module">
            <div class="view_item_title"> <strong>Yarsca 24in Beach Cruiser Bike! </strong></div>
            <div class="view_item_prices_list">
                <div class="view_item_prices_per_hour"> $8/hour </div> -
                <div class="view_item_prices_per_day"> $12/day </div> -
                <div class="view_item_prices_per_week"> $20/week </div> -
                <div class="view_item_prices_per_month"> $35/month </div>
            </div>
            <div class="view_item_listed_date_module">
                <div class="view_item_listed_date_name"> <strong>Listed date:</strong> </div>
                <div class="view_item_listed_date"> 20th July, 2024, </div>
                <div class="view_item_listed_date_count"> 7 days ago </div>
            </div>
            <div class="view_item_location_module">
                <div class="view_item_location_name"> <strong>Location:</strong></div>
                <div class="view_item_location"> Santa Cruz, CA </div>
            </div>
            <div class="view_item_category_module">
                <div class="view_item_category_name"> <strong>Category:</strong> </div>
                <div class="view_item_category"> Bike </div>
            </div>
            <div class="view_item_features_module">
                <div class="view_item_features_name"> <strong>Features:</strong></div>
                <div class="view_item_features"> Multiple colors - </div> 
                <div class="view_item_features"> Adjustable seats - </div>
                <div class="view_item_features"> Anti-lock system </div>
            </div>
            <div class="view_item_description_module">
                <div class="view_item_description_name"> <strong>Description</strong></div>
                <div class="view_item_description">Lorem ipsum odor amet, consectetuer adipiscing elit. Pulvinar est dui sem velit curae duis! Adipiscing orci aliquet blandit habitant aptent lorem. Placerat vestibulum scelerisque primis natoque fames scelerisque laoreet. Placerat mi natoque mattis ridiculus nisl curabitur consequat. Vulputate nec praesent suspendisse conubia ac feugiat turpis finibus magna. Venenatis orci condimentum eleifend sagittis per elementum. Porttitor leo fames porttitor habitasse mi nisi.

                    Lorem ipsum odor amet, consectetuer adipiscing elit. Pulvinar est dui sem velit curae duis! Adipiscing orci aliquet blandit habitant aptent lorem. Placerat vestibulum scelerisque primis natoque fames scelerisque laoreet. Placerat mi natoque mattis ridiculus nisl curabitur consequat. Vulputate nec praesent suspendisse conubia ac feugiat turpis finibus magna. Venenatis orci condimentum eleifend sagittis per elementum. Porttitor leo fames porttitor habitasse mi nisi.
                </div>
                <div class="view_item_description_see_more"> See more </div>
            </div>
            <div class="view_item_user_module">
                <img src="profilepic1.png" class="view_item_user_profile_picture">
                <div class="view_item_view_user_profile"> SEE INFO </div>
                <div class="view_item_user_module_1">
                    <div class="view_item_user_name"> Phuc Thinh Nguyen </div>
                    <div class="view_item_user_module_2">
                        <div class="view_item_reviews"> 4.5 </div>
                        <div class="view_item_reviews_count"> - 144 reviews </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="view_item_line"></div>

        <div class="view_item_duration_module">
            <input type="text" class="view_item_duration_months" placeholder="Months">
            <input type="text" class="view_item_duration_weeks" placeholder="Weeks">
            <input type="text" class="view_item_duration_days" placeholder="Days">
            <input type="text" class="view_item_duration_hours" placeholder="Hours">
            <input type="text" class="view_item_duration_minutes" placeholder="Minutes">
        </div>
        
        <div class="view_item_cancel_add_module">
            <div class="view_item_quantity_module">
                <div class="view_item_quantity_deduct"> - </div>
                <div class="view_item_quantity_number"> 1 </div>
                <div class="view_item_quantity_add"> + </div>
            </div>
            <div class="view_item_add_to_cart_module"> Add to cart </div>
            <div class="view_item_close"> Close </div>
        </div>
        <%
            // OPTIONAL TODO: FIX WEBSITE REFRESH ONCE ITEM IS ADDED TO CART
            if (request.getParameter("addToCart") != null && !userID.equals("0")) {
                // add to cart(userId, itemId)
                // out.println("parameter not null, button has been clicked");
                try {
                    java.sql.Connection con;
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false",user, password);
        
                    Statement stmt = con.createStatement();

                    String addToCartQuery = String.format("INSERT INTO cart (UserID, ItemID) VALUES (%s, %s);", userID, id);
                    // out.println(addToCartQuery);

                    int ri = stmt.executeUpdate(addToCartQuery);
                    // out.println("item added to cart");
                    
                    stmt.close();
                    con.close();
                } catch(SQLException e) {
                    out.println("SQLException caught: " + e.getMessage());
                }
            }
        %>
    </div>

    <div class="view_user_profile">
        <div class="view_user_profile_1">
            <img src="profilepic1.png" alt="" class="profile_picture">
            <div class="view_user_profile_2_asterisk">
                <div class="view_user_profile_2">
                    <div class="view_user_profile_3">
                        <div class="email_icon"></div>
                        <div class="phone_number_icon"></div>
                    </div>
                    <div class="view_user_profile_4">
                        <div class="email">drgenius2003@gmail.com</div>
                        <div class="phone_number"> (510) 240-0454</div>
                    </div>
                </div>
                <div class="view_user_profile_module">
                    <div class="view_user_profile_module_add_friend"></div>
                    <div class="view_user_profile_module_message">Message</div>
                    <div class="view_user_profile_module_see_rentals">Rentals</div>
                </div>
            </div>
        </div>
        <div class="user_full_name"> Phuc Thinh Nguyen </div>
        <div class="member_date"> Member since November 21st, 2023 </div>
        <div class="current_location"> Currently at Santa Cruz, CA </div>
        <div class="view_user_profile_line"></div>
        <div class="renter_reviews_module">
            <div class="renter_reviews_name"> Renter reviews</div>
            <div class="renter_reviews"> 4.5 <i class="fas fa-star" id="renter_review_star_icon"></i></div>
        </div>
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
        $('.view_item_add_to_cart_module').click(function() {
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
        });

        $(document).ready(function() {
            let item_id = 0;
            $('.grid_container .grid_item').click(function() {
                item_id = $(this).index() + 1;
            });
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
        const imageFilenames = [
            'test_add_image_1.png',
            'test_add_image_2.png',
            'test_add_image_3.png',
            'test_add_image_4.png',
            'test_add_image_5.png'
        ];

        let currentImageIndex = 0;

        function updateImage() {
            const testPhotoDiv = document.querySelector('.view_item_photo');
            testPhotoDiv.innerHTML = '';
            const imgElement = document.createElement('img');
            imgElement.src = imagesPath + imageFilenames[currentImageIndex];
            testPhotoDiv.appendChild(imgElement);

        }

        const imagesPath = 'C:/Users/Admin/Downloads/PDVProject-main/CS157A Project/';

        document.getElementById('photo_back_button').addEventListener('click', () => {
            if (currentImageIndex === 0) {
                currentImageIndex = imageFilenames.length - 1;
            }
            else {
                currentImageIndex = currentImageIndex - 1;
            }
            updateImage();
        });

        document.getElementById('photo_front_button').addEventListener('click', () => {
            if (currentImageIndex === imageFilenames.length - 1) {
                currentImageIndex = 0;
            }
            else {
                currentImageIndex = currentImageIndex + 1;
            }
            updateImage();
        });
        updateImage();
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
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.grid_item').click(function() {
                if ($('.view_item_module').css('display') === 'block') {
                    $('.view_item_module').css('display', 'none');
                    $('.blur_background').css('display', 'none');
                }
                else {
                    $('.view_item_module').css('display', 'block');
                    $('.blur_background').css('display', 'block');
                }
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
                if ($('#login-module').css('display') === 'block') {
                    $('#login-module').css('display', 'none');
                    $('.signup_login_button').removeClass('active');
                }
                else {
                    $('#login-module').css('display', 'block');
                    $('.signup_login_button').addClass('active');
                }
            });

            $(document).click(function(event) {
                if (!$(event.target).closest('.signup_login_button, #login-module').length) {
                    $('#login-module').css('display', 'none');
                    $('.signup_login_button').removeClass('active');
                }
            });
        });
    </script>


</body>
</html>
