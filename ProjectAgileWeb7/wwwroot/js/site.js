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


const kToC = function (kelvin) {

    return Math.round(kelvin - 273.15);
}

const getToday = function () {
    let today = new Date();
    const monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"];
    const weekdaysName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
        "Friday", "Saturday"];

    let myWeekday = weekdaysName[today.getDay()];
    let date = today.getDate() + ' ' + monthNames[today.getMonth()] + ' ' + today.getFullYear()

    return myWeekday + ' ' + date;
}

const getTimeNow = function () {
    var today = new Date();
    return today.getHours() + ":" + today.getMinutes();
}

const getWeather = function () {
    const baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
    const apiKey = '2fa2b9559079337382b2c8d5b4817940';
    const latitude = document.getElementById('latitude').value;
    const longitude = document.getElementById('longitude').value;
    let queryString = `lat=${latitude}&lon=${longitude}&appid=${apiKey}`;
    let endpoint = baseUrl + queryString;
    const temperature = document.getElementById('temperature');
    const weather = document.getElementById('weather');
    const location = document.getElementById('location');
    const today = document.getElementById('today');
    const time = document.getElementById('time');
    const description = document.getElementById('description');
    const weatherIcon = document.getElementById('weather-icon');
    const wind = document.getElementById('wind');


    fetch(endpoint)
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {

            if (data.cod === 200) {

                switch (data.weather[0].main) {
                    case 'Rain':
                        weatherIcon.innerHTML = '<i class="fas fa-cloud-rain fa-2x text-info"></i>';
                        break;
                    case 'Clouds':
                        weatherIcon.innerHTML = '<i class="fas fa-cloud fa-2x text-secondary"></i>';
                        break;
                    case 'Clear':
                        weatherIcon.innerHTML = '<i class="fas fa-sun fa-2x text-warning"></i>';
                        break;
                    case 'Snow':
                        weatherIcon.innerHTML = '<i class="fas fa-snowflake fa-2x text-info"></i>';
                        break;
                    default:
                        weatherIcon.innerHTML = ' <i class="fas fa-cloud-sun fa-2x text-primary"></i>';
                }

                location.innerHTML = data.name;
                weather.innerHTML = data.weather[0].main;
                description.innerHTML = data.weather[0].description;
                temperature.innerHTML = kToC(data.main.temp) + '°C';
                wind.innerHTML = data.wind.speed;
                today.innerHTML = getToday();
                time.innerHTML = getTimeNow();
            }
            else {
                weather.innerHtml = 'No weather data available';
            }
        })
        .catch(function (error) {
            return console.log(error);
        });


}



$(document).ready(function () {
    $('#submit-btn').attr('disabled', true);
    $('#search-input').keyup(function () {
        ($(this).val().length == 0) ? $('#submit-btn').attr('disabled', true) : $('#submit-btn').attr('disabled', false);
    });

    //$('#my-testing-button').click(function () {
    //    getWeather();
    //});
    getWeather();
});
