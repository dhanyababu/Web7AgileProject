*** Settings ***
Library                                  SeleniumLibrary
Library                                  RequestsLibrary



*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank                ${BROWSER}		options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                       ${URL}


Before search
        ${search_text_clear}=           Get Element Attribute        id:search-input    attribute=value
        Should Be Equal                 ${search_text_clear}         ${EMPTY}
        ${Search_in_date} =             Get element attribute        id:check-in        attribute=value
        Should Be Equal                 ${Search_in_date}            2020-April-30
        ${Search_out_date} =            Get element attribute        id:check-out       attribute=value
        Should Be Equal                 ${Search_out_date}           2020-May-01


Input search text
        Input Text                      id:search-input              London


Input date
        Click Element                   id:check-in
        Press Keys                      id:check-in                  CTRL+ARROW_DOWN     ENTER
        Click Element                   id:check-out
        Press Keys                      id:check-out                 CTRL+ARROW_DOWN     ENTER



Click Search
        Click Element                   xpath://*[@id="search-form"]/div/div/div/div[2]
        Wait Until Page Contains        London                      timeout=10


Search text before clear
        ${search_text_old} =           Get element attribute        id:search-input           attribute=value
        Should Be Equal                ${search_text_old}           London
        ${Search_in_date} =            Get element attribute        id:check-in               attribute=value
        Should Be Equal                ${Search_in_date}            2020-May-07
        ${Search_out_date} =           Get element attribute        id:check-out              attribute=value
        Should Be Equal                ${Search_out_date}           2020-May-13


Click clear filter
        Sleep      5
        Element Should Be Visible      xpath:/html/body/div[1]/main/a
        Click Element                  xpath:/html/body/div[1]/main/a
      Sleep         5


Verify filter
        ${search_text_clear}=          Get Element Attribute        id:search-input      attribute=value
        Should Be Equal                ${search_text_clear}         ${EMPTY}
        ${Search_in_date} =            Get element attribute        id:check-in          attribute=value
        Should Be Equal                ${Search_in_date}            2020-April-30



End Web Test
        Close Browser
