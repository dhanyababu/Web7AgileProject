*** Settings ***
Documentation
Resource  ../Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***

Filter Window 1024x768
    Change Window Size          640     960
    Use Valid Login
    View Filters Mobile
    Test WiFi Filter
    View Filters Mobile
    Test Breakfast Filter
    View Filters Mobile
    Test Room Service Filter
    View Filters Mobile
    Test Fitness Center Filter
    View Filters Mobile
    Test Pool Filter
    View Filters Mobile
    Test Sauna Filter
    View Filters Mobile
    Three Star Filter
    View Filters Mobile
    Four Star Filter
    View Filters Mobile
    Five Star Filter
    View Filters Mobile
    1km Filter
    View Filters Mobile
    3km Filter
    View Filters Mobile
    5km Filter
    View Filters Mobile
    10km Filter