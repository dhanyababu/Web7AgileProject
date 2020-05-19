*** Settings ***
Documentation
Resource  ../Resources/placeskeywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***
Verify List Appears
    Use Valid Login
    Check If Nearby Places Appear

Verify Lists Are Expandable
    Use Valid Login
    Check If Lists Are Expandable

Verify List Size Of Restaurants Are Correct
    Use Valid Login
    Check If Given Size 16 Of Restaurant List Is Correct

Verify List Size Of Culture Are Correct
    Use Valid Login
    Check If Given Size 0 Of Culture List Is Correct

Verify List Size Of Bars Are Correct
    Use Valid Login
    Check If Given Size 2 Of Bars List Is Correct

Verify List Size Of Shopping Are Correct
    Use Valid Login
    Check If Given Size 1 Of Shopping List Is Correct