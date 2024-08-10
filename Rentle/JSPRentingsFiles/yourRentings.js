function initializeTimersForCurrentGridItem() {
    $('.your_rentings_current_grid_item').each(function() {
        var divText = $(this).find('.your_rentings_current_grid_item_duration_name').text().trim();
        var seconds = parseFloat(divText);
        
        $(this).find('.your_rentings_current_grid_item_duration_name').text(formatTime(seconds));

        var timeRemainingDiv = $(this).find('.your_rentings_current_grid_item_time_remaining_name').text().trim();
        var timeRemainingSeconds = parseFloat(timeRemainingDiv);

        $(this).find('.your_rentings_current_grid_item_time_remaining_name').text(formatTime(timeRemainingSeconds));

        var interval = setInterval(() => {
            if (timeRemainingSeconds > 0) {
                timeRemainingSeconds--;
                $(this).find('.your_rentings_current_grid_item_time_remaining_name').text(formatTime(timeRemainingSeconds));
            } else {
                clearInterval(interval);
            }
        }, 1000);
    });
}

function viewPastRentings() {
    var currentUserId = $('#user_id').text().trim();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPRentingsFiles/viewPastRentings.jsp?currentUserId=" + encodeURIComponent(currentUserId), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                document.getElementById("your_rentings_past_grid_container").innerHTML = xhr.responseText;
                console.log(xhr.responseText);
            } catch (e) {
                console.log("Something wrong with rentings view");
            }
        }
    };
    xhr.send();
}

function viewCurrentRentings() {
    var currentUserId = $('#user_id').text().trim();
    var xhr = new XMLHttpRequest();

    xhr.open("GET", "JSPRentingsFiles/viewCurrentRentings.jsp?currentUserId=" + encodeURIComponent(currentUserId), true);
                    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                document.getElementById("your_rentings_current_grid_container").innerHTML = xhr.responseText;
                initializeTimersForCurrentGridItem();
            } catch (e) {
                console.error(e);
            }
        }
    };
    xhr.send();
}


