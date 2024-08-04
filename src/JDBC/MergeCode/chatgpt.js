// TODO: ADD THIS CODE TO HTML FILE AS SCRIPT AND ADD API KEY
const apiKey = 'API_KEY_GOES_HERE';

async function sendMessage() {
    const message = document.getElementById('inputbox').value;
    const chatbox = document.getElementById('chatbox');

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
                    {role: 'system', content: 'You are a helpful assistant on a rental application that suggests different vehicles such as google cars, scooters, cars, bikes, etc. Respond in 100 tokens or less.'},
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
        console.log(chatResponse);
    } catch (error) {
        console.error('Error:', error);
    }
}