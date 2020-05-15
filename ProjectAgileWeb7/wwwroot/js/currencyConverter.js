let baseCurrency;
let amountPerNightToConvert;
let amountTotalToConvert;
let selectedCurrency;
let exchangeRate;
let newPerNightAmount;
let newTotalAmount;
let ajaxResult;

$(document).ready(function () {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $(".totalPriceHidden").val($(".totalPriceDisplayLabel").text());
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
                exchangeRate = parseFloat(ajaxResult[selectedCurrency]);

                newPerNightAmount = (amountPerNightToConvert * exchangeRate).toFixed(2);
                newTotalAmount = (amountTotalToConvert * exchangeRate).toFixed(2);
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
