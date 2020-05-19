*** Settings ***
Documentation
Resource  ../Tester/Resources/keywordswthr.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login

*** Test Cases ***

Test Weather

    Use Valid Login
    Check Weather Appearance
