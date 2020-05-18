*** Settings ***
Documentation
Resource  ../Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login
${date_to_select} =  0020200507


*** Test Cases ***


Test If Search Works With No Chosen Dates
    Use Valid Login
    Input Text Into Searchbar No Dates


Test If Search Works With Dates
    Use Valid Login
    Input Text Into Searchbar With Dates


Test If Search Works With No Chosen Dates And Invalid Search Input
    Use Valid Login
    Input Invalid Text Into Searchbar

