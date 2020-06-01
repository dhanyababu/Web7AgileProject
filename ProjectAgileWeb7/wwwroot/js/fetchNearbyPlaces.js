
const getPlacesNearby = function () {
    const baseUrlPath = "https://places.ls.hereapi.com/places/v1/discover/explore?";
    const apiKey = "CIFDa7Y1OWPrVKL-VUgnzaSZ01kCdQ553yn8HZaiyfc";
    const latitude = document.getElementById('latitude');
    const longitude = document.getElementById('longitude');
    if (latitude != null) {
        latitudeValue = latitude.value;
    }
    else {
        latitudeValue = null;
    }

    if (longitude != null) {
        longitudeValue = longitude.value;
    }
    else {
        longitudeValue = null;
    }
    let queryString = `at=${latitudeValue},${longitudeValue}`;
    let endpoint = baseUrlPath + "apiKey=" + apiKey + "&" + queryString;

    if (latitudeValue != null && longitudeValue != null) {
        fetch(endpoint)
            .then(response => response.json())
            .then(data => {
                //console.log(data);
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
                    //console.log(item.category.id);
                });
            })
            .catch(function (error) {
                return console.log(error);
            });
    }



}
