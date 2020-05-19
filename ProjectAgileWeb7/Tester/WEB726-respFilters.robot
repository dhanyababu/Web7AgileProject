*** Settings ***
Documentation
Resource  ../Tester/Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***

Filter Window 1024x768
    Change Window Size          512    396
    Use Valid Login
    Test WiFi Filter
    Test Breakfast Filter
    Test Room Service Filter
    Test Fitness Center Filter
    Test Pool Filter
    Test Sauna Filter
    Three Star Filter
    Four Star Filter
    Five Star Filter
    1km Filter
    3km Filter
    5km Filter
    10km Filter
