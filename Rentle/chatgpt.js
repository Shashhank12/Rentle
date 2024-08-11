// TODO: ADD THIS CODE TO HTML FILE AS SCRIPT AND ADD API KEY
const apiKey = '';

function sendMessageToGPT() {
    var currentUserId = $('#user_id').text().trim();
    var inputText = $('#inputbox').val().trim();

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("POST", "JSPViewFiles/viewUserProfileChatGPT.jsp?currentUserId=" + encodeURIComponent(currentUserId) +
                        "&inputText=" + encodeURIComponent(inputText), true);

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var chatbox = document.getElementsByClassName('ai_module_wrapper')[0];
            chatbox.innerHTML += xmlhttp.responseText; // Append the response
            $('#inputbox').val(''); // Clear the input box
        }
    }
    xmlhttp.send();
}

async function sendMessage() {
    const message = document.getElementById('inputbox').value;
    const chatbox = document.getElementById('chatbox');

    if (message.trim() === '') return;
;

    try {
        const response = await fetch('https://api.openai.com/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                model: 'gpt-3.5-turbo',
                messages: [
                    { role: 'system', content: 'You are a helpful assistant on a rental application that suggests different vehicles such as google cars, scooters, cars, bikes, etc. Respond in 100 tokens or less.' },
                    { role: 'user', content: message }
                ],
                max_tokens: 150
            })
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        const chatResponse = data.choices[0].message.content;

        // Add ChatGPT's response to the chatbox
        var chatModule1 = $('<div class="chatbox_module_1"></div>');
        var userMessage1 = $('<div class="user_message_1"></div>');
        var gptProfilePic = $('<img src="" class="gpt_profile_pic">');

        // Set the text and attributes
        userMessage1.text(chatResponse);
        gptProfilePic.attr('src', 'images/profilepicgroup.png');

        // Append elements to the chat module
        chatModule1.append(gptProfilePic);
        chatModule1.append(userMessage1);

        // Append the chat module to the chatbox
        $('.ai_module_wrapper').append(chatModule1);
    } catch (error) {
        console.error('Error:', error);
    }
}