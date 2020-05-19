*** Settings ***
Documentation
Resource  ../Tester/Resources/keywordsExpDte.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***

Test Card Expiration Date

    Use Valid Login
    Book Room
    Check If Card-Date Input Appears

Verify Expiration date Works
    Use Valid Login
    Book Room
    Login While Booking Room

Verify Exp Date Option1 Equals Current Month
    Use Valid Login
    Book Room
    Verify Exp Date Is Up To Date
