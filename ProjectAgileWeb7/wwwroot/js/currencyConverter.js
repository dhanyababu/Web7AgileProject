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
    })

    $(".selectedCurrency").focus(function () {
        baseCurrency = $(this).val();
    });

    $(".selectedCurrency").on('change', function () {
        selectedCurrency = $(".selectedCurrency option:selected").text();
        amountPerNightToConvert = parseFloat($(".perNightPriceDisplay").text());
        amountTotalToConvert = parseFloat($(".totalPriceDisplayLabel").text());

        $(".selectedCurrency").blur();

        $.ajax({
            url: "https://prime.exchangerate-api.com/v5/a5f16bf9860bddcdd3cf4c43/latest/" + baseCurrency,
            type: "GET",
            dataType: "json",
            success: function (response) {
                ajaxResult = response.conversion_rates;
                exchangeRate = parseFloat(ajaxResult[selectedCurrency]);

                newPerNightAmount = (amountPerNightToConvert * exchangeRate).toFixed(2).replace(/\./g, ',');
                newTotalAmount = (amountTotalToConvert * exchangeRate).toFixed(2).replace(/\./g, ',');
                $(".perNightPriceDisplay").text(newPerNightAmount)
                $(".totalPriceDisplayLabel").text(newTotalAmount);
                $(".totalPriceHidden").val(newTotalAmount);
            },
            error: function (response) {
                console.log(JSON.stringify(response));
            }
        });

    });
});
