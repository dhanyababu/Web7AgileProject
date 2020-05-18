*** Settings ***
Documentation
Resource  ../Resources/keywordsbook.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***
Test Booking While Logged In
    Use Valid Login
    Book Room
    Login While Booking Room

CardNumber Too Short
    Use Valid Login
    Book Room
    Booking Credit Card Number Too Short

Cardnumber Too Long
    Use Valid Login
    Book Room
    Booking Cardnumber Too Long

Cardnumber Letters
    Use Valid Login
    Book Room
    Booking Cardnumber Letters

Test Booking No Login
   Book Room
   No Login While Booking Room


