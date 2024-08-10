// Format seconds into meaningful terms (126000 seconds into hours and minutes)
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

// Calculate total seconds for cart
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