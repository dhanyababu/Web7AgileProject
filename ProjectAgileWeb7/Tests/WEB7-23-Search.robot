*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage
Resource        ../Tests/Resources/WEB7-23-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verify clear filter
            [Documentation]            Test to verify that Clear filter button is clearing  various search input
            [Tags]                     Test WEb7-155
            Before search
            Input search text
            Input date
            Click Search
            Search text before clear
            Click clear filter
            Verify filter


Verify calendar start date is uptodate
            [Documentation]            Test to verify that calendar check in start date is current date and  checkout
            ...                         date is one ahead from check in date
            [Tags]                     Test WEb7-118
            Select start date in calendar
            Verify start date is current date



Verify calendar end date
            [Documentation]            Test to verify that calendar checkin maximum date is one year ahead from less a day current date
            ...                        and check out date is one year ahead from current date,checkin and checkout date minimum difference is
            ...                        one day
            [Tags]                     Test WEb7-118 1.1
            Select end date in calendar
            Verify end date of calendar


Verify calendar date is between limit
            [Documentation]            Test to verify that calendar selecting date is in between start date(current date) and end date
            ...                         (one year ahead from current day).
            [Tags]                     Test WEb7-118 1.2
            Select a random date
            Verify random date is in between limit








