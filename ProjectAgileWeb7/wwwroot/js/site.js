// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

$(window).on('resize', mobileSearchForm);
$(window).on('load', mobileSearchForm);

function mobileSearchForm() {
    if ($(window).width() < 1000) {
        $('#heading').css('fontSize', '2rem');
        $('#search-btn').show();
        $('#search-form').addClass('collapse');
        $('.custom-file').removeClass('p-4');
        $('.custom-file').addClass('p-3');
        $('#search-icon').hide();

    }
    else {
        $('#heading').css('fontSize', '3rem');
        $('#search-btn').hide();
        $('#search-form').removeClass('collapse');
        $('.custom-file').addClass('p-4');
        $('.custom-file').removeClass('p-3');
        $('#search-icon').show();
    }
}

$(document).ready(function () {
    $("#check-in").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 0,
        dateFormat: 'dd/mm/yy',
        onSelect: function (selectedDate) {
            $('#check-out').datepicker('option', 'minDate', selectedDate);
        }
    });
    $("#check-out").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 0,
        dateFormat: 'dd/mm/yy',
        onSelect: function (selectedDate) {
            $('#check-in').datepicker('option', 'minDate', selectedDate);
        }
    });
});
