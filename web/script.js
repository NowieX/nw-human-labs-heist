$(document).ready(function() {
    $("#container").hide();
    window.addEventListener('message', function(event) {
        if (event.data.action === "open") {
            $("#container").fadeIn(400);
        }
    });

    $(document).keyup(function(e) {
        if (e.key === "Escape") { // escape key maps to keycode `27`
            $("#container").fadeOut(400);
            $.post('https://nw-human-labs/nw-human-labs:client:closeBlueprintUI')
        }
    });
});