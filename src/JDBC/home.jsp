<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>CS157A Project</title>
    <link rel="stylesheet" href="Homepage.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <script src="Homepage.js"></script>
    <script src="jquery-3.7.1.min.js"></script>
    <%
        String userID = "0";
        try {
            userID = session.getAttribute("userID").toString();
        } catch (IllegalStateException e) {
            out.println("IllegalStateException caught: " + e.getMessage());
        }
    %>
</head>
<body style="overflow-x: hidden;">
    <img src="images/image1.png" alt = "" class="rectangle-image">
    <div class="leftbar">
        <input type="text" id="location_search" name="searchbox" placeholder="Address, ZIP Code, ...">

        <div class="icon_circle">
            <div class="icon"></div>
        </div>

        <div class="search_icon"></div>

        <div id="your_rentals">
            <div class="your_rentals_icon"></div>
            <div class="your_rentals_text"> Past rentals </div>
        </div>

        <div id="your_rentings">
            <div class="your_rentings_icon"></div>
            <div class="your_rentings_text"> Past rentings </div>
        </div>

        <div id="messages">
            <div class="messages_icon"></div>
            <div class="messages_text"> Messages </div>
        </div>

        <div id="friends">
            <div class="friends_icon"></div>
            <div class="friends_text"> Friends </div>
        </div>

        <div class="line"></div>

        <input type="text" id="interested_rents" name="searchbox" placeholder="What's in your mind?...">
        <div class="searchrent_icon"></div>

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
                <input type="text" id="min_location" name="min_location" placeholder="Min.">
                <div class="to"> to </div>
                <input type="text" id="max_location" name="max_location" placeholder="Max.">
            </div>
        </div>

        <div id="condition">
            <div id="condition_module">
                <div class="condition_icon"></div>
                <div class="condition_text"> Condition </div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Excellent </div>
                <div class="condition_checkbox"></div>
                <div class="condition_check"></div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Good </div>
                <div class="condition_checkbox"></div>
                <div class="condition_check"></div>
            </div>
            <div id="condition_module_2">
                <div class="condition_text_2"> Fair </div>
                <div class="condition_checkbox"></div>
                <div class="condition_check"></div>
            </div>
        </div>

        <div class="space"></div>

    </div>
    <div class="homepage_bar">
        <img src="images/image2.png" alt = "" class="logo">
        <div class="settings_icon"></div>
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
                <div class="signup_login_text">Welcome <%=userID%>!</div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <div id="login-module">
        <div class="login-background">
            <div class="username"> Username </div>
            <input type="text" id="username" name="searchbox" placeholder="Email, username, or phone number">
            <div class="password"> Password </div>
            <input type="password" id="password" name="searchbox" placeholder="">
            <div id="login-button-module">
                <div class="login_button_background"></div>
                <div class="login_text"> Login </div>
            </div>
            <div id="signup_notification_component">
                <div class="not_a_member_text"> Not a member? </div>
                <div class="signup_hyperlink"> Sign up</div>
            </div>
        </div>
    </div>

    <div id="wrapper">
        <div class="rectangle">
            <div class="rectangle_center_component" id="rectangle_center_component"></div>
        </div>
    </div>
    <div class="rightbar" id="rightbar">
        <div class="grid_container">
            <div class="grid_item">
                <img src="images/image3.png" alt = "" class="item_image">
                <div class="item_name"> Bicycle for rent! </div>
                <div class="item_module_1">
                    <div class="item_module_2">
                        <div class="item_category"> Bike - </div>
                        <div class="item_feature"> Multiple gears </div>
                    </div>
                    <div class="item_price"> $15 </div>
                </div>
                <div class="item_location"> San Jose, CA </div>
            </div>

            <div class="grid_item">
                <img src="images/image4.png" alt = "" class="item_image">
                <div class="item_name"> Waymo 5th Generation </div>
                <div class="item_module_1">
                    <div class="item_module_2">
                        <div class="item_category"> Automobile - </div>
                        <div class="item_feature"> Self-driving </div>
                    </div>
                    <div class="item_price"> $19.5 </div>
                </div>
                <div class="item_location"> Mountain View, CA </div>
            </div>

            <div class="grid_item">
                <img src="images/image5.png" alt = "" class="item_image">
                <div class="item_name"> Gotrax Scooter Rent $1/hour </div>
                <div class="item_module_1">
                    <div class="item_module_2">
                        <div class="item_category"> Scooter - </div>
                        <div class="item_feature"> Speakers </div>
                    </div>
                    <div class="item_price"> $12.5 </div>
                </div>
                <div class="item_location"> Hayward, CA </div>
            </div>
        </div>
    </div>

    <div id="your_rentals_view">
        <div class="your_rentals_history_text"> Your rental history</div>
        <div class="your_rentals_line"></div>
        <div class="your_rentals_grid_container">
            <div class="your_rentals_grid_item"> 1 </div>
            <div class="your_rentals_grid_item"> 2 </div>
        </div>
    </div>
    <div id="your_rentings_view">
        <div class="your_rentings_history_text"> Your renting history</div>
        <div class="your_rentings_grid_container"></div>
    </div>
    <div id="messages_view"></div>
    <div id="friends_view"></div>

    <script>
        const your_rentals_button = document.getElementById('your_rentals');
        const your_rentings_button = document.getElementById('your_rentings');
        const your_messages_button = document.getElementById('messages');
        const your_friends_button = document.getElementById('friends');

        const your_rentals_view = document.getElementById('your_rentals_view');
        const your_rentings_view = document.getElementById('your_rentings_view');
        const messages_view = document.getElementById('messages_view');
        const friends_view = document.getElementById('friends_view');

        your_rentals_button.addEventListener('click', function() {
            if (your_rentals_view.style.display === 'none') {
                your_rentals_view.style.display = 'block';
                your_rentings_view.style.display = 'none';
                messages_view.style.display = 'none';
                friends_view.style.display = 'none';
            } else {
                your_rentals_view.style.display = 'none';
            }
        });

        your_rentings_button.addEventListener('click', function() {
            if (your_rentings_view.style.display === 'none') {
                your_rentings_view.style.display = 'block';
                your_rentals_view.style.display = 'none';
                messages_view.style.display = 'none';
                friends_view.style.display = 'none';
            } else {
                your_rentings_view.style.display = 'none';
            }
        });

        your_messages_button.addEventListener('click', function() {
            if (messages_view.style.display === 'none') {
                messages_view.style.display = 'block';
                your_rentals_view.style.display = 'none';
                your_rentings_view.style.display = 'none';
                friends_view.style.display = 'none';
            } else {
                messages_view.style.display = 'none';
            }
        });

        your_friends_button.addEventListener('click', function() {
            if (friends_view.style.display === 'none') {
                friends_view.style.display = 'block';
                your_rentals_view.style.display = 'none';
                your_rentings_view.style.display = 'none';
                messages_view.style.display = 'none';
            } else {
                friends_view.style.display = 'none';
            }
        });
    </script>

    <script>
        $(document).ready(function() {
            $('#signup_container').on('click', function() {
                $(this).toggleClass('clicked');
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            let rightbar = document.querySelector('.rightbar');
            let gridContainer = document.querySelector('.grid_container');
            let gridItems = document.querySelectorAll('.grid_item');

            let initialRightBarWidth = rightbar.clientWidth;
            let initialHeight = (window.innerWidth - 50) * 0.14; 
            let initialHeight2 = 0;
            let bool = 0;

            gridItems.forEach(item => {
                item.style.height = `${initialHeight}px`;
            });

            function getGridColumnCount() {
                let style = window.getComputedStyle(gridContainer);
                let columns = style.getPropertyValue('grid-template-columns');
                let columnCount = columns.split(' ').filter(column => column !== '').length;
                return columnCount;
            }

            let initialColumnCount = getGridColumnCount();

            function adjustHeight() {
                const currentColumnCount = getGridColumnCount();
                const currentRightBarWidth = rightbar.clientWidth;
                const heightDifference = currentRightBarWidth - initialRightBarWidth;
                let newHeight;

                if (initialColumnCount === currentColumnCount) {
                    if (bool === 1) {
                        newHeight = initialHeight2 + heightDifference * 0.25;
                    } else {
                        newHeight = initialHeight + heightDifference * 0.25;
                    }
                } else {
                    console.log(initialColumnCount, currentColumnCount);
                    if (initialColumnCount < currentColumnCount) {
                        newHeight = initialHeight;
                        bool = 0;
                    } else {
                        newHeight = initialHeight2;
                        bool = 1;
                    }
                    initialColumnCount = currentColumnCount;
                    initialRightBarWidth = currentRightBarWidth;
                }

                if (newHeight >= initialHeight2) {
                    initialHeight2 = newHeight;
                }
                gridItems.forEach(item => {
                    item.style.height = `${newHeight}px`;
                });
            }   
            const resizeObserver = new ResizeObserver(adjustHeight);
            resizeObserver.observe(rightbar);
        });
    </script>

    <script>
        var wrapper = document.getElementById("wrapper");
        var rectangle_center_component = document.getElementById("rectangle_center_component");
        var right_bar = document.getElementById("rightbar");
        handleDrag(wrapper, rectangle_center_component, right_bar);
    </script>

    <script>
        var category_dropdown_arrow = document.getElementsByClassName("category_dropdown_arrow");
        var features_dropdown_arrow = document.getElementsByClassName("features_dropdown_arrow");

        var category_list = document.getElementsByClassName("category_list");
        var features_list = document.getElementsByClassName("features_list");

        handleClickDropdown(category_dropdown_arrow[0], category_list[0]);
        handleClickDropdown(features_dropdown_arrow[0], features_list[0]);
    </script>

    <script>
        const signupContainer = document.querySelector('#signup_container');
        const loginModule = document.querySelector('#login-module');
        
        handleClickShowModule(signupContainer, loginModule);

        document.addEventListener('click', (event) => {
            const withinBoundaries = event.composedPath().includes(signupContainer) || event.composedPath().includes(loginModule);

            if (!withinBoundaries && loginModule.style.display === 'block') {
                loginModule.style.display = 'none';
            }
        });

        document.addEventListener('click', (event) => {
            const noColor = event.composedPath().includes(signupContainer) || event.composedPath().includes(loginModule);

            if (!noColor && loginModule.style.background === 'block') {
                loginModule.style.display = 'none';
            }
        });
    </script>



</body>
</html>