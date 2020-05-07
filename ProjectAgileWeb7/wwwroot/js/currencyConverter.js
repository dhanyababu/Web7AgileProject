var amountToConvert = "";
var baseCurrency = "";
var selectedCurrency = "";
var exchangeRate = "";
var newAmount = "";
var ajaxResult = [];

$(document).ready(function () {
    $("#selectedCurrency").focusin(function () {
        baseCurrency = $("#selectedCurrency option:selected").text();
    });

    $("#selectedCurrency").on('change', function () {
        selectedCurrency = $("#selectedCurrency option:selected").text();
        amountToConvert = $("#totalPriceDisplay").val();

        $.ajax({
            url: "https://prime.exchangerate-api.com/v5/a5f16bf9860bddcdd3cf4c43/latest/" + baseCurrency,
            type: "GET",
            dataType: "json",
            success: function (response) {
                ajaxResult = response.conversion_rates;
                exchangeRate = ajaxResult[selectedCurrency];
                console.log(exchangeRate);
                newAmount = (amountToConvert * exchangeRate).toFixed(2);
                console.log(newAmount);
                $("#totalPriceDisplay").val(newAmount);
            },
            error: function (response) {
                console.log(JSON.stringify(response));
            }
        });

    });
});