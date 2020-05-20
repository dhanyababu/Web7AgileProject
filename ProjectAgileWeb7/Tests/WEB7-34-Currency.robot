*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage for verifying currency selection of booking page
Resource        ../Tests/Resources/WEB7-34-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =      https://localhost:44364/


*** Test Cases ***
Verify currency list SEK
    [Documentation]                 Test to verify that currency change in payment option of booking page is changing according to the
    ...                             selection of currency
    [Tags]                          Test WEb7-255
    Goto register
    Register account                testing@gmail.com          Test123$
    Search hotel
    See details
    Verify price per night
    Book room
    Select SEK currency
    Verify SEK Payment details
    Select USD currency
    Verify USD Payment details      0.1033
    Select EUR currency
    Verify EUR Payment details      0.094
    Select RON currency
    Verify RON Payment details      0.4553
    Select CZK currency
    Verify CZK Payment details      2.5988
    Confirm payment in CZK
    Goto my bookings
    Verify Booking



