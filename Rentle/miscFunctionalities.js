// Format date time in cart
function formatTimeForCart() {
    $('.cart_item').each(function() {
        var text = $(this).find('.cart_item_duration').text().trim();
        var textToSeconds = parseFloat(text);
        console.log(formatTime(textToSeconds));
        $(this).find('.cart_item_duration').text(formatTime(textToSeconds));
    });
}

// A draggable bar to extend items view.
function handleDrag(obj1, obj2, obj3) {
    var mousedown = false;
    var initialMouseX = 0;
    var initialObj1X = 0;
    var initialObj3Width = 0;

    obj2.addEventListener('mousedown', function(e) {
        e.preventDefault();
        mousedown = true;
        initialMouseX = e.clientX;
        initialObj1X = parseInt(window.getComputedStyle(obj1).left, 10);
        initialObj3Width = parseInt(window.getComputedStyle(obj3).width, 10);
    });

    document.addEventListener('mouseup', function() {
        mousedown = false;
    });
     
    document.addEventListener('mousemove', function(e) {
        if (mousedown) {
            e.preventDefault();
            var diff = e.clientX - initialMouseX;
            obj1.style.left = initialObj1X + diff + 'px';
            obj3.style.width = initialObj3Width - diff + 'px';
        }
    });
}

// View items in cart
function viewCart() {
    var currentUserId = $('#user_id').text().trim();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPViewFiles/viewCart.jsp?currentUserId=" + encodeURIComponent(currentUserId), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                document.getElementsByClassName("cart_list")[0].innerHTML = xhr.responseText;
                formatTimeForCart();
                console.log("Inside cart");
            } catch (e) {
                console.error(e);
            }
        }
    };
    xhr.send();
}

// View all items in a list
function viewAllItems() {
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPViewFiles/viewAllItems.jsp", true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            $('.grid_container').empty();
            document.getElementsByClassName("grid_container")[0].innerHTML = xhr.responseText;
            console.log("success");
        }
    };
    xhr.send();
}

// View a single item in a list 
function viewItem() {
    var currentItemId = $('.view_item_index').text().trim();
    var currentUserId = $('#user_id').text().trim();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPViewFiles/viewItem.jsp?currentItemId=" + encodeURIComponent(currentItemId) +
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

// Checkout cart
function cartCheckout() {
    var currentUserId = $('#user_id').text().trim();
    var total = $('.cart_total_price').text().trim();

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "cartCheckout.jsp?currentUserId=" + encodeURIComponent(currentUserId) +
                    "&total=" + encodeURIComponent(total) , true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log("True");
            
        } else {
            console.log("Failed");
        }
    };
    xhr.send();
}

// Submit review
function submitReview() {
    var currentUserId = $('#user_id').text().trim();
    var renterUserId = $('.your_rentings_past_grid_item').attr('value').trim();
    var starRating = $('.your_rentings_past_user_review_info_star').attr('value').trim();

    var criterias = $('.your_rentings_past_user_review_info_criteria').data('criteria_attr');
    criterias = criterias.substring(0, criterias.length - 1);

    var descriptionText = $('.your_rentings_past_user_review_info_description').val().trim();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "submitReview.jsp?currentUserId=" + encodeURIComponent(currentUserId) +
                    "&renterUserId=" + encodeURIComponent(renterUserId) +
                    "&starRating=" + encodeURIComponent(starRating) + 
                    "&criteria=" + encodeURIComponent(criterias) +
                    "&description=" + encodeURIComponent(descriptionText), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                console.log("Reviews added");
            } catch (e) {
                console.error(e);
            }
        }
    };
    xhr.send();
}

// View all people in friends tab
function viewAllPeople() {
    var xhr = new XMLHttpRequest();

    var inputVal = $('.friends_search').val().trim();
    console.log(inputVal);

    xhr.open("GET", "JSPViewFiles/viewAllPeople.jsp?inputVal=" + encodeURIComponent(inputVal), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                document.getElementsByClassName('friends_view_module_1_grid_all_people')[0].innerHTML = xhr.responseText;
                console.log("Success");
            } catch (e) {
                console.error(e);
            }
        }
    };
    xhr.send();
}

// View friends only in Friends tab
function viewAllFriends() {
    var currentUserId = $('#user_id').text().trim();
    var inputVal = $('.friends_search').val();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPViewFiles/viewAllFriends.jsp?currentUserId=" + encodeURIComponent(currentUserId) +
                    "&inputVal=" + encodeURIComponent(inputVal), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                document.getElementsByClassName('friends_view_module_1_grid_friends_only')[0].innerHTML = xhr.responseText;
                console.log("Success");
            } catch (e) {
                console.error(e);
            }
        }
    };
    xhr.send();
}

function addFriend() {
    var itemUserId = $('.friends_view_user_id').text().trim();
    var currentUserId = $('#user_id').text().trim();

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "friends?currentUserId=" + encodeURIComponent(currentUserId) +
                        "&itemUserId=" + encodeURIComponent(itemUserId), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            try {
                console.log("Friend added");
            } catch (e) {
                console.error(e);
            }
        }
    }
    xmlhttp.send(null);
}

function reloadFriends() {
    var itemUserId = $('.friends_view_user_id').text().trim();
    var currentUserId = $('#user_id').text().trim();

    var xmlhttp;

    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.open("POST", "reloadfriends?currentUserId=" + encodeURIComponent(currentUserId) +
                        "&itemUserId=" + encodeURIComponent(itemUserId), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            try {
                if (itemUserId === currentUserId) {
                    return;
                }
                var friendsArray = xmlhttp.responseText.split(",");

                // Remove any existing '.view_user_profile_module_add_friend_friends_tab'
                $('.view_user_profile_module_friends_tab').find('.view_user_profile_module_add_friend_friends_tab').remove();

                var friendsTab = $('<div class="view_user_profile_module_add_friend_friends_tab"></div>');

                // Apply styles and text based on the conditions
                if (friendsArray[2] === '1') { // Use '1' as a string for comparison
                    friendsTab.css({
                        'background': 'rgb(199, 231, 198)',
                        'color': 'rgb(55, 161, 52)'
                    }).text('Friends');
                }
                else if (friendsArray[2] === '0') { // Use '0' as a string for comparison
                    if (currentUserId === friendsArray[0]) {
                        friendsTab.css({
                            'background': 'rgb(231, 231, 198)',
                            'color': 'rgb(161, 152, 52)'
                        }).text('Pending');
                    }
                    else {
                        friendsTab.css({
                            'background': 'rgb(231, 231, 198)',
                            'color': 'rgb(161, 152, 52)'
                        }).text('Accept');
                    }
                }
                else {
                    friendsTab.css({
                        'background': 'rgb(231, 198, 198)',
                        'color': 'rgb(211, 74, 74)'
                    }).text('Add friend');
                }

                // Insert the new tab at the beginning of the children in '.view_user_profile_module_friends_tab'
                $('.view_user_profile_module_friends_tab').prepend(friendsTab);
            } catch (e) {
                console.error(e);
            }
        }
    }
    xmlhttp.send(null);
    setTimeout(reloadFriends, 500);
}