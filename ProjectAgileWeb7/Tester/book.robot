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

Test Booking No Login
   Book Room
   No Login While Booking Room