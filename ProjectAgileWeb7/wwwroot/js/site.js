// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

$(window).on('resize', mobileSearchForm);
$(window).on('load', mobileSearchForm);

function mobileSearchForm() {
    if ($(window).width() < 1000) {
        $('#heading').css('fontSize', '2rem');
        $('.date-input').hide();
        $('.date-input-sm').show;
        $('#search-submit-btn').removeClass('btn-lg');
    }
    else {
        $('#heading').css('fontSize', '3rem');
        $('.date-input').show();
        $('.date-input-sm').hide();
        $('#search-submit-btn').addClass('btn-lg');
    }
}
