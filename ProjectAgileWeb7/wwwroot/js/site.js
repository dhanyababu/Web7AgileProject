// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

$(window).on('resize', mobileSearchForm);
$(window).on('load', mobileSearchForm);

function mobileSearchForm() {
    if ($(window).width() < 990) {
        $('#heading').css('fontSize', '2rem');
        $('#search-btn').show();
        $('#search-form').addClass('collapse');
        $('.custom-file').removeClass('p-4');
        $('.custom-file').addClass('p-3');
        $('.hide-icon').hide();
        $('#submit-btn').addClass('btn-block');
        $('#filter-button').show();
        $('#filter-form-id').addClass('collapse');
        $('#filter-title').hide();

    }
    else {
        $('#heading').css('fontSize', '3rem');
        $('#search-btn').hide();
        $('#search-form').removeClass('collapse');
        $('.custom-file').addClass('p-4');
        $('.custom-file').removeClass('p-3');
        $('.hide-icon').show();
        $('#submit-btn').removeClass('btn-block');
        $('#filter-button').hide();
        $('#filter-form-id').removeClass('collapse');
        $('#filter-title').show();
    }
}

$(document).ready(function () {
    $("#check-in").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 0,
        maxDate: '+1Y',
        dateFormat: 'yy-MM-dd',
        onSelect: function (selectedDate) {
            var date = $(this).datepicker('getDate');
            if (date) {
                date.setDate(date.getDate() + 1);
            }
            $('#check-out').datepicker('option', 'minDate', date || 1);
        }
    }).val('');
    $("#check-out").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 1,
        maxDate: '+1Y',
        dateFormat: 'yy-MM-dd'
    }).val('');
});

$(document).ready(function () {
    $('#submit-btn').attr('disabled', true);
    $('#search-input').keyup(function () {
        ($(this).val().length == 0) ? $('#submit-btn').attr('disabled', true) : $('#submit-btn').attr('disabled', false);
    })
});
