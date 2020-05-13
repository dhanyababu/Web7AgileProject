var amountPerNightToConvert = "";
var amountTotalToConvert = "";
var baseCurrency = "";
var selectedCurrency = "";
var exchangeRate = "";
var newPerNightAmount = "";
var newTotalAmount = "";
var ajaxResult = [];

$(document).ready(function () {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })

    $(".selectedCurrency").focus(function () {
        baseCurrency = $(this).val();
    });

    $(".selectedCurrency").on('change', function () {
        selectedCurrency = $(".selectedCurrency option:selected").text();
        amountPerNightToConvert = $(".perNightPriceDisplay").text();
        amountTotalToConvert = $(".totalPriceDisplayLabel").text();

        $(".selectedCurrency").blur();

        $.ajax({
            url: "https://prime.exchangerate-api.com/v5/a5f16bf9860bddcdd3cf4c43/latest/" + baseCurrency,
            type: "GET",
            dataType: "json",
            success: function (response) {
                ajaxResult = response.conversion_rates;
                exchangeRate = ajaxResult[selectedCurrency];

                newPerNightAmount = (amountPerNightToConvert * exchangeRate).toFixed(2);
                newTotalAmount = (amountTotalToConvert * exchangeRate).toFixed(2);
                $(".perNightPriceDisplay").text(newPerNightAmount)
                $(".totalPriceDisplayLabel").text(newTotalAmount);
                $(".totalPriceDisplay").val(newTotalAmount);
            },
            error: function (response) {
                console.log(JSON.stringify(response));
            }
        });

    });
});