*** Settings ***
Documentation
Library  SeleniumLibrary
Library  DateTime


*** Keywords ***
Begin Login Test
    Open Browser                            about:blank     ${BROWSER}
    Go To                                   ${URL}
    Wait Until Page Contains                Use a local account to log in.

Use Valid Login

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Hello balder@hotmail.com!

Check If Nearby Places Appear
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Wait Until Page Contains Element        xpath://*[@id="nearby-categories"]

Check If Lists Are Expandable
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Wait Until Page Contains Element        xpath://*[@id="nearby-categories"]
    Click Element                           xpath://*[@id="restaurants"]/summary/i
    Click Element                           xpath://*[@id="restaurants"]/details[1]/summary
    Wait Until Page Contains Element        xpath://*[@id="restaurants"]/details[1]/span

Check If Given Size 16 Of Restaurant List Is Correct
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Click Element                           xpath://*[@id="restaurants"]/summary/i
    ${Count}=    Get Element Count           //*[@id="restaurants"]/details
    Log                                     ${Count}
    Should Be Equal As Integers             ${Count}        16

Check If Given Size 2 Of Bars List Is Correct
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Click Element                           xpath://*[@id="bars"]/summary/i
    ${Count}=    Get Element Count           //*[@id="bars"]/details
    Log                                     ${Count}
    Should Be Equal As Integers             ${Count}        2

Check If Given Size 0 Of Culture List Is Correct
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Click Element                           xpath://*[@id="culture"]/summary/i
    ${Count}=    Get Element Count          //*[@id="culture"]/details
    Log                                     ${Count}
    Should Be Equal As Integers             ${Count}        0

Check If Given Size 1 Of Shopping List Is Correct
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   2s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   2s
    Click Element                           xpath://*[@id="shopping"]/summary/i
    ${Count}=    Get Element Count          //*[@id="shopping"]/details
    Log                                     ${Count}
    Should Be Equal As Integers             ${Count}        1


End Test
    Close Browser