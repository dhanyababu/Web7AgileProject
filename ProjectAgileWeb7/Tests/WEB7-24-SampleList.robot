*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage for verifying the sample list of hotels
Resource        ../Tests/Resources/WEB7-24-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verify image is visible in Homepage
    [Documentation]                 Test to verify that Home page is displayed with sample list of hotels images
    [Tags]                          Test WEb7-49
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[1]/img
    Verify src of first image       xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[1]/img
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[1]/img
    Verify src of second image      xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[1]/img
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[1]/img
    Verify src of third image       xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[1]/img


Verify name and details
    [Documentation]                 Test to verify that Home page is displayed names and details of hotels
     ...                            along with images
    [Tags]                          Test WEb7-49 1.1
    Verify first hotel
    Verify second hotel
    Verify third hotel


Verify Page is responsive
     [Documentation]                Test to verify that Web page is responsive with window size and is displayed names and details of hotels
     ...                            along with images
    [Tags]                          Test WEb7-143
    Change window size value        300  500
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[1]/img
    Verify src of first image       xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[1]/img
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[1]/img
    Verify src of second image      xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[1]/img
    Verify image is visible         xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[1]/img
    Verify src of third image       xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[1]/img
    Verify first hotel
    Verify second hotel
    Verify third hotel












