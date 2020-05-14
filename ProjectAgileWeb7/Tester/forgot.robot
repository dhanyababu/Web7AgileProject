##*** Settings ***
Documentation
Resource  ../Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


##*** Test Cases ***

Forgot Password Test
    Click Button                        xpath://*[@id="forgot-password"]
    Input Text                          id:Input_Email      balder19971@hotmail.com
    Click Button                        xpath://html/body/div/main/div/div/form/button
    Open Window
    Go To                               https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=13&ct=1587626205&rver=7.0.6737.0&wp=MBI_SSL&wreply=https%3a%2f%2foutlook.live.com%2fowa%2f%3fnlp%3d1%26RpsCsrfState%3ddc24b7d9-f80c-c1b6-7541-6e72285684b7&id=292841&aadredir=1&CBCXT=out&lw=1&fl=dob%2cflname%2cwld&cobrandid=90015
    Input Text                          id:i0116            balder19971@hotmail.com
    Click Button                        xpath://*[@id="idSIButton9"]
    Input Text                          id:i0118            Balder111.
    Click Button                        xpath://*[@id="idSIButton9"]
    Wait Until Page Contains