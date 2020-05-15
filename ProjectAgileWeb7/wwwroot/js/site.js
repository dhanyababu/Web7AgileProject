// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

$(window).on('resize', mobileVersion);
$(window).on('load', mobileVersion);

function mobileVersion() {
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
        $('.payment-input').removeClass('col-3');
        $('.mobile-toggle').hide();
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
        $('.payment-input').addClass('col-3');
        $('.mobile-toggle').show();
    }
}

$(document).ready(function () {
    var checkin = $("#check-in").attr('placeholder'); // Test this
    var checkout = $("#check-out").attr('placeholder'); // Test this

    $("check-in").text(checkin); // Test this
    $("check-out").text(checkout); // Test this
    
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
    }).val(checkin);
    $("#check-out").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 1,
        maxDate: '+1Y',
        dateFormat: 'yy-MM-dd'
    }).val(checkout);
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
                    case 'Drizzle':
                        weatherIcon.innerHTML = '<i class="fas fa-cloud-sun-rain fa-2x text-secondary"></i>';
                        break;
                    case 'Mist':
                        weatherIcon.innerHTML = '<i class="fas fa-smog fa-2x text-secondary"></i>';
                        break;
                    case 'Fog':
                        weatherIcon.innerHTML = '<i class="fas fa-smog fa-2x text-secondary"></i>';
                        break;
                    case 'Haze':
                        weatherIcon.innerHTML = '<i class="fas fa-smog fa-2x text-secondary"></i>';
                        break;
                    case 'Thunderstorm':
                        weatherIcon.innerHTML = '<i class="fas fa-bolt fa-2x text-warning"></i>';
                        break;
                    case 'Tornado':
                        weatherIcon.innerHTML = '<i class="fas fa-cloud-showers-heavy fa-2x text-info"></i>';
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
    //if ($('#search-input').val().length == 0) {
    //    $('#submit-btn').attr('disabled', true);
    //}
    //$('#search-input').keyup(function () {
    //    ($(this).val().length == 0) ? $('#submit-btn').attr('disabled', true) : $('#submit-btn').attr('disabled', false);
    //});

    getWeather();
    getPlacesNearby();
});

const getPlacesNearby = function () {
    const baseUrlPath = "https://places.ls.hereapi.com/places/v1/discover/explore?";
    const apiKey = "CIFDa7Y1OWPrVKL-VUgnzaSZ01kCdQ553yn8HZaiyfc";
    const latitude = document.getElementById('latitude').value;
    const longitude = document.getElementById('longitude').value;
    let queryString = `at=${latitude},${longitude}`;
    let endpoint = baseUrlPath + "apiKey=" + apiKey + "&" + queryString;

    fetch(endpoint)
        .then(response => response.json())
        .then(data => {
            console.log(data);
            let restaurantsCount = 0;
            let barsCount = 0;
            let cultureCount = 0;
            let shopsCount = 0;
            data.results.items.forEach(item => {
                if (item.category.id === "restaurant" || item.category.id === "food-drink") {
                    restaurantsCount++;
                    document.getElementById('restaurantsCount').innerHTML = restaurantsCount;
                    document.getElementById('restaurants').innerHTML += "<details><summary><i class=\"fas fa-chevron-circle-down fa-sm\"></i> &nbsp;" + item.title + "</summary><span class=\"small text-muted text-capitalize\"><span class=\"text-primary\">Type: </span>" + item.category.id + " (" + item.tags[0].id + ")</br><span class=\"text-primary\">Distance: </span>" + item.distance + " m</br><span class=\"text-primary\">Address:</span></br>" + item.vicinity + "<hr>";
                }
                else if (item.category.id === "bar-pub" || item.category.id === "coffee-tea" || item.category.id === "dance-night-club" || item.category.id === "going-out") {
                    barsCount++;
                    document.getElementById('barsCount').innerHTML = barsCount;
                    document.getElementById('bars').innerHTML += "<details><summary><i class=\"fas fa-chevron-circle-down fa-sm\"></i> &nbsp;" + item.title + "</summary><span class=\"small text-muted text-capitalize\"><span class=\"text-primary\">Type: </span>" + item.category.id + "</br><span class=\"text-primary\">Distance: </span>" + item.distance + " m</br><span class=\"text-primary\">Address:</span></br>" + item.vicinity + "<hr>";
                }
                else if (item.category.id === "theatre-music-culture" || item.category.id === "sights-museums") {
                    cultureCount++;
                    document.getElementById('cultureCount').innerHTML = cultureCount;
                    document.getElementById('culture').innerHTML += "<details><summary><i class=\"fas fa-chevron-circle-down fa-sm\"></i> &nbsp;" + item.title + "</summary><span class=\"small text-muted text-capitalize\"><span class=\"text-primary\">Type: </span>" + item.category.id + "</br><span class=\"text-primary\">Distance: </span>" + item.distance + " m</br><span class=\"text-primary\">Address:</span></br>" + item.vicinity + "<hr>";
                }
                else if (item.category.id === "shop" || item.category.id === "bookshop" || item.category.id === "clothing-accessories-shop" || item.category.id === "department-store") {
                    shopsCount++;
                    document.getElementById('shopsCount').innerHTML = shopsCount;
                    document.getElementById('shopping').innerHTML += "<details><summary><i class=\"fas fa-chevron-circle-down fa-sm\"></i> &nbsp;" + item.title + "</summary><span class=\"small text-muted text-capitalize\"><span class=\"text-primary\">Type: </span>" + item.category.id + "</br><span class=\"text-primary\">Distance: </span>" + item.distance + " m</br><span class=\"text-primary\">Address:</span></br>" + item.vicinity + "<hr>";
                }
                console.log(item.category.id);
            });
        })
        .catch(function (error) {
            return console.log(error);
        });

}
