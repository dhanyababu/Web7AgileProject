*** Settings ***
Documentation
Resource  ../Tester/Resources/keywordsmyF.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login



*** Test Cases ***

Mark As Favourite
    Use Valid Login
    Mark As Favourite

Delete Favourite
    Use Valid Login
    Delete Favourite

Mark Multiple As Favourite
    Use Valid Login
    Multiple Favourite

Delete Multiple Favourite
    Use Valid Login
    Delete Multiple Favourite
