/// Login
function login() {
    var uname = document.getElementById('username');
    var pw = document.getElementById('password');
    if (uname.value == '' || pw.value == '') {
        console.log("Please try again");
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
                location.reload(true);
            }
        }
    }
    xmlhttp.send(null);
}

function logout() {
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "logout.jsp", true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {
            console.log("True");
            location.reload(true);
        }
    }
    xmlhttp.send(null);
}

// Add a new text
function addText() {
    var userId = document.getElementById("user_id").textContent.trim();
    var msg = document.getElementsByClassName('message_input')[0].value.trim();
    var group_id = document.getElementsByClassName('currentGroupId')[0].textContent.trim();
    document.getElementsByClassName('message_input')[0].value = '';

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var encodedMsg = encodeURIComponent(msg);
    xmlhttp.open("POST", "chatstore?userId=" + userId 
        + "&msg=" + encodedMsg 
        + "&currentGroupId=" + group_id
        + "", true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {
            console.log("True");
            $('.your_messages_add_group_chat_people_grid').children().not(':last').remove();
            $('.your_messages_add_group_chat_module, .your_messages_add_group_chat_people_grid').css('display', 'none');
        }
    }
    xmlhttp.send(null);
}

// Add a new group chat
function addGroup() {
    var groupUsers = document.getElementsByClassName("your_messages_add_group_chat_people_grid")[0].querySelectorAll('.your_messages_add_group_chat_people_grid_item_user_id');

    var groupIdUsers = document.getElementById("user_id").innerHTML.trim();

    groupUsers.forEach(function(user) {
        groupIdUsers = groupIdUsers + "," + user.innerHTML + ',';
        groupIdUsers = groupIdUsers.slice(0, -1);
    });   

    console.log(groupIdUsers);
    
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var encodedGroupUsers = encodeURIComponent(groupIdUsers);
    xmlhttp.open("POST", "group?groupUsers=" + encodedGroupUsers, true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {
            console.log("All completed");
        }
    }
    xmlhttp.send(null);
}

// Reload message 
function reloaddata() {
    var currentGroupIdElement = document.getElementsByClassName('currentGroupId')[0].textContent.trim();
    var currentUserId = document.getElementById("user_id").textContent.trim();
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var encodedGroupId = encodeURIComponent(currentGroupIdElement);
    xmlhttp.open("POST", "reloaddata?currentGroupIdElement=" + encodedGroupId, true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            try {
                var newMessages = JSON.parse(xmlhttp.responseText);
                var allUserId = [];
                var allMessageContents = [];
                var allProfilePictures = [];
                for (let i = 0; i < newMessages.length; i++) {
                    allUserId.push(newMessages[i].user_id);
                    allMessageContents.push(newMessages[i].message_content);
                    allProfilePictures.push(newMessages[i].profile_picture);
                }
                var oldLength = $('.messages_area_grid').children().length;
                $('.messages_area_grid').empty();

                for (let i = 0; i < allUserId.length; i++) {
                    var messageItem = $('<div class="messages_area_grid_item"></div>');
                    var profilePicture = $('<img>', {
                        class: 'messages_area_grid_item_profile_picture'
                    });
                    var messageContent = $('<div class="messages_area_grid_item_message_content"></div>');

                    if (i === allUserId.length - 1) {
                        profilePicture.attr('src', allProfilePictures[i]);
                    }
                    else {
                        if (allUserId[i] !== allUserId[i + 1]) {
                            profilePicture.attr('src', allProfilePictures[i]);
                        }
                        else {
                            profilePicture.css('opacity', '0')
                        }
                    }
                    messageContent.text(allMessageContents[i]);

                    // Apply style if user_id matches currentUserId
                    if (allUserId[i] === currentUserId) {
                        messageItem.append(messageContent);
                        messageItem.append(profilePicture);
                        messageItem.css('display', 'flex');
                        messageItem.css('justify-content', 'flex-end');
                        messageItem.css('margin-right', '10px');
                        messageContent.css('background', 'rgb(248, 229, 250)');
                    }
                    else {
                        messageItem.append(profilePicture);
                        messageItem.append(messageContent);
                        messageContent.css('background', 'rgb(229, 249, 250)');
                        messageItem.css('margin-left', '10px');
                    }
                    $('.messages_area_grid').append(messageItem);
                }
                var newLength = $('.messages_area_grid').children().length;
                if (newLength > oldLength) {
                    setTimeout(function() {
                        var messagesArea = $('.messages_area_grid')[0];
                        messagesArea.scrollTop = messagesArea.scrollHeight;
                    }, 0);
                }
            } catch (e) {
                console.error(e);
            }
        }
        $('.message_enter, .people_messages_item').click(function() {
            setTimeout(function() {
                var messagesArea = $('.messages_area_grid')[0];
                messagesArea.scrollTop = messagesArea.scrollHeight;
            }, 0);
        });
        
    }
    xmlhttp.send(null);
    setTimeout(reloaddata, 500);
}

// Reload the group data so user will see new messages on the grid
function reloadDataGroup() {
    var currentUserId = document.getElementById("user_id").textContent.trim();

    var inputVal = $('#people_search').val().trim();
    if (inputVal === "" || inputVal === null) {
        inputVal = "";
    } else {
        inputVal = inputVal.replace(/\s+/g, "");
    }

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "reloaddatagroup?currentUserId=" 
        + encodeURIComponent(currentUserId), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var newMessages = JSON.parse(xmlhttp.responseText);
            var allGroupId = [], allNames = [], allProfilePictures = [], allMessageContents = [];
            for (let i = 0; i < newMessages.length; i++) {
                var newText = newMessages[i].name;
                if (newText === "" || newText === null) {
                    newText = "";
                } else {
                    newText = newText.replace(/\s+/g, "");
                }
                if (newText.includes(inputVal)) {
                    allGroupId.push(newMessages[i].group_id);
                    allNames.push(newMessages[i].name);
                    allProfilePictures.push(newMessages[i].profile_picture);
                    allMessageContents.push(newMessages[i].content);
                }
            }

            $('#people_messages_grid').empty();

            for (let i = 0; i < allGroupId.length; i++) {
                var messageItem = $('<div class="people_messages_item"></div>');
                var groupId = $('<div class="group_id"></div>');
                var profilePicture = $('<img>', {
                    class: 'people_messages_profile_pic'
                });
                var messageModule = $('<div class="people_messages_module"></div>')
                var messageName = $('<div class="people_messages_name"></div>')
                var messageContent = $('<div class="people_messages_content"></div>');

                groupId.text(allGroupId[i]);
                groupId.css('display', 'none');
                profilePicture.attr('src', allProfilePictures[i]);
                messageName.text(allNames[i]);
                messageContent.text(allMessageContents[i]);

                messageItem.append(groupId);
                messageItem.append(profilePicture);
                messageItem.append(messageModule);
                messageModule.append(messageName);
                messageModule.append(messageContent);

                $('#people_messages_grid').append(messageItem);
            }
        }
    }
    xmlhttp.send(null);
    setTimeout(reloadDataGroup, 500);
}

// Deleting the group that is creating if user no longer interested
function deleteLastItem() {
    var deletedElement = $('#people_messages_grid').children().first();

    console.log($('#people_messages_grid').children().length);

    var deletedGroupId = deletedElement.find('.group_id').text().trim();

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "deletelastitem?deletedGroupId=" + encodeURIComponent(deletedGroupId), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {
            console.log("True");
        }
    }
    xmlhttp.send(null);
}

// Display the names on top of each group ID
function viewProfileModule() {
    var currentGroupIdElement = document.getElementsByClassName('currentGroupId')[0].textContent.trim();
    var currentUserId = document.getElementById("user_id").textContent.trim();

    var xmlhttp;
    if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else { // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "JSPMessageFiles/newProfileModule.jsp?currentGroupIdElement=" + encodeURIComponent(currentGroupIdElement) +
                        "&currentUserId=" + encodeURIComponent(currentUserId), true);

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementsByClassName('messages_person_module')[0].innerHTML = xmlhttp.responseText;
            console.log("Module loaded");
        }
    }
    xmlhttp.send(null);
}

// Select people to add to pending group chat
function findPeopleToAdd() {
    var currentUserId = document.getElementById("user_id").textContent.trim();
    var inputVal = $('.your_messages_add_group_chat_text').val();

    var groupUsers = document.getElementsByClassName("your_messages_add_group_chat_people_grid")[0].querySelectorAll('.your_messages_add_group_chat_people_grid_item_user_id');

    var groupIdUsers = document.getElementById("user_id").innerHTML.trim();

    groupUsers.forEach(function(user) {
        groupIdUsers = groupIdUsers + "," + user.innerHTML + ',';
        groupIdUsers = groupIdUsers.slice(0, -1);
    });   

    console.log(groupIdUsers);

    var xmlhttp;
    if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else { // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "JSPMessageFiles/findPeopleToAdd.jsp?inputVal=" + encodeURIComponent(inputVal) +
                "&userId=" + encodeURIComponent(currentUserId) +
                "&groupUsers=" + encodeURIComponent(groupIdUsers), true);

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementsByClassName('your_messages_add_group_chat_grid')[0].innerHTML = xmlhttp.responseText;
            console.log("Group chat people found");
        }
    }
    xmlhttp.send(null);
}

// Fetch the new pending group ID
function fetchNewGroupId() {
    $.ajax({
        url: 'JSPMessageFiles/newGroupId.jsp',
        method: 'POST',
        success: function(data) {
            console.log(data);
            $('.your_messages_add_group_chat_new_group_id').text(data);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching group ID:', error);
        }
    });
}