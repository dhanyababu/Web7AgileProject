

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
        $('.button-group-icons').show();
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
        $('.button-group-icons').hide();
    }
}

$(document).ready(function () {
    var checkin = $("#check-in").attr('placeholder');
    var checkout = $("#check-out").attr('placeholder');

    $("#check-in").datepicker({
        showAnim: 'drop',
        numberOfMonths: 1,
        minDate: 0,
        maxDate: '+1Y',
        dateFormat: 'yy-MM-dd',
        onSelect: function () {
            var date = $(this).datepicker('getDate');
            if (date) {
                date.setDate(date.getDate() + 1);
                chosenCheckin = date;
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
    const latitude = document.getElementById('latitude');
    if (latitude != null) {
        latitudeValue = latitude.value;
    }
    else {
        latitudeValue = null;
    }
    const longitude = document.getElementById('longitude');
    if (longitude != null) {
        longitudeValue = longitude.value;
    }
    else {
        longitudeValue = null;
    }

    let queryString = `lat=${latitudeValue}&lon=${longitudeValue}&appid=${apiKey}`;
    let endpoint = baseUrl + queryString;
    const temperature = document.getElementById('temperature');
    const weather = document.getElementById('weather');
    const location = document.getElementById('location');
    const today = document.getElementById('today');
    const time = document.getElementById('time');
    const description = document.getElementById('description');
    const weatherIcon = document.getElementById('weather-icon');
    const wind = document.getElementById('wind');

    if (latitudeValue != null && longitudeValue != null) {
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
}

$(document).ready(function () {
    getWeather();
    getPlacesNearby();
});
