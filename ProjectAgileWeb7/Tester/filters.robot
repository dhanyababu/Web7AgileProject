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
Verify Filters Work
    Use Valid Login
    Test WiFi Filter
    Test Breakfast Filter
    Test Room Service Filter
    Test Fitness Center Filter
    Test Pool Filter
    Test Sauna Filter

Verify Stars Filter Work
    Use Valid Login
    Three Star Filter
    Four Star Filter
    Five Star Filter

Veirfy Distance Filters
    Use Valid Login
    1km Filter
    3km Filter
    5km Filter
    10km Filter