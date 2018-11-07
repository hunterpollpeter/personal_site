document.addEventListener("turbolinks:load", function() {
    $('iframe').on("load", function() {
        $(this).addClass('loaded');
    });
});
