let initialPricePerNight;
let initialTotalPrice;
let baseCurrency;
let amountPerNightToConvert;
let amountTotalToConvert;
let selectedCurrency;
let exchangeRate;
let newPerNightAmount;
let newTotalAmount;
let ajaxResult;

$(document).ready(function () {
    initialPricePerNight = $("#initialPricePerNight").val();
    initialTotalPrice = $("#initialTotalPrice").val();

    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $(".totalPriceHidden").val($(".totalPriceDisplayLabel").text());
    })

    $(".selectedCurrency").on('change', function () {
        selectedCurrency = $(".selectedCurrency option:selected").text();

        $(".selectedCurrency").blur();

        $.ajax({
            url: "https://prime.exchangerate-api.com/v5/a5f16bf9860bddcdd3cf4c43/latest/SEK/",
            type: "GET",
            dataType: "json",
            success: function (response) {
                ajaxResult = response.conversion_rates;
                exchangeRate = ajaxResult[selectedCurrency];

                newPerNightAmount = parseFloat(initialPricePerNight * exchangeRate).toFixed(2);
                newTotalAmount = parseFloat(initialTotalPrice * exchangeRate).toFixed(2);
                $(".currentCurrency").text(selectedCurrency);
                $(".perNightPriceDisplay").text(newPerNightAmount);
                $(".totalPriceDisplayLabel").text(newTotalAmount);
                $(".totalPriceHidden").val(newTotalAmount);
            },
            error: function (response) {
                console.log(JSON.stringify(response));
            }
        });

    });
});
