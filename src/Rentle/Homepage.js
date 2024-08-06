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


function login() {
    var uname = document.getElementById('username');
    var pw = document.getElementById('password');
    if (uname.value == '' || pw.value == '') {
        $(document).ready(function () {
            $('.error_module').css('display', 'block');
            $('#login-module').css({
                'height': '29%',
                'display': 'block'
            });
        });
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
            var intervalId = setInterval(function() {
                reloaddata();
                clearInterval(intervalId);
            }, 500);
            $('.your_messages_add_group_chat_people_grid').children().not(':last').remove();
            $('.your_messages_add_group_chat_module, .your_messages_add_group_chat_people_grid').css('display', 'none');
        }
    }
    xmlhttp.send(null);
}


function addGroup() {
    var groupUsers = document.getElementsByClassName("your_messages_add_group_chat_people_grid")[0].querySelectorAll('.your_messages_add_group_chat_people_grid_item_user_id');
    var currentGroupId = document.getElementsByClassName("currentGroupId")[0].textContent.trim();
    var groupIdUsers = document.getElementById("user_id").innerHTML.trim();

    groupUsers.forEach(function(user) {
        groupIdUsers = groupIdUsers + "," + user.innerHTML + ','
        groupIdUsers = groupIdUsers.slice(0, -1);
    });   
    
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
            console.log("True");
        }
    }
    xmlhttp.send(null);
}

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
                    var intervalId = setInterval(function() {
                        reloadDataGroup();
                        clearInterval(intervalId);
                    }, 500);
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
}

function reloadDataGroup() {
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

    xmlhttp.open("POST", "reloaddatagroup?currentUserId=" 
        + encodeURIComponent(currentUserId), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var newMessages = JSON.parse(xmlhttp.responseText);
            var allGroupId = [], allNames = [], allProfilePictures = [], allMessageContents = [];
            for (let i = 0; i < newMessages.length; i++) {
                allGroupId.push(newMessages[i].group_id);
                allNames.push(newMessages[i].name);
                allProfilePictures.push(newMessages[i].profile_picture);
                allMessageContents.push(newMessages[i].content);
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
}

function deleteLastItem() {
    var deletedElement = $('#people_messages_grid').children().last();

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
