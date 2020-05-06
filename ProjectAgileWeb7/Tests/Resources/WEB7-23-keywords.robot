*** Settings ***
Library                                  SeleniumLibrary
Library                                  RequestsLibrary
Library                                  DateTime
Library                                  String


*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank                ${BROWSER}     options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                       ${URL}


Before search
        ${search_text_clear}=           Get Element Attribute        id:search-input    attribute=value
        Should Be Equal                 ${search_text_clear}         ${EMPTY}
        ${Search_in_date} =             Get element attribute        id:check-in        attribute=value
        Should Be Equal                 ${Search_in_date}            0001-01-01
        ${Search_out_date} =            Get element attribute        id:check-out       attribute=value
        Should Be Equal                 ${Search_out_date}           0001-01-01


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
        ${current_date} =              Get Current Date             local                                       result_format=%Y-%m-%d
        ${selected_checkin_date}=      Add Time To Date             ${current_date}           7 days            result_format=%Y-%b-%d
        ${Search_in_date} =            Get element attribute        id:check-in               attribute=value
        Should Be Equal                ${Search_in_date}            ${selected_checkin_date}
        ${selected_checkout_date}=     Add Time To Date             ${current_date}          15 days            result_format=%Y-%b-%d
        ${Search_out_date} =           Get element attribute        id:check-out              attribute=value
        Should Be Equal                ${Search_out_date}           ${selected_checkout_date}


Click clear filter
        Wait Until Page Contains Element    xpath:/html/body/div[1]/main/a
        Element Should Be Visible           xpath:/html/body/div[1]/main/a
        Click Element                       xpath:/html/body/div[1]/main/a



Verify filter
        ${search_text_clear}=          Get Element Attribute        id:search-input         attribute=value
        Should Be Equal                ${search_text_clear}         ${EMPTY}
        ${Search_in_date} =            Get element attribute        id:check-in             attribute=value
        Should Be Equal                ${Search_in_date}            0001-01-01
        ${Search_out_date} =           Get element attribute        id:check-out            attribute=value
        Should Be Equal                ${Search_out_date}           0001-01-01


Select start date in calendar

        Wait Until Page Contains Element    id:search-input
        Input Text                          id:search-input              London
        Click Element                       id:check-in
        Mouse Over                          css:div#ui-datepicker-div table.ui-datepicker-calendar td.ui-datepicker-today
        Click Element                       css:div#ui-datepicker-div table.ui-datepicker-calendar td.ui-datepicker-today
        Click Element                       id:check-out
        Press Keys                          id:check-out                 CTRL     ENTER
        Click Element                       xpath://*[@id="search-form"]/div/div/div/div[2]


Verify start date is current date
        ${current_date} =              Get Current Date             local                                       result_format=%Y-%b-%d
        ${Search_in_date} =            Get element attribute        id:check-in               attribute=value
        Should Be Equal                ${Search_in_date}            ${current_date}
        ${current_date} =              Get Current Date             local                                       result_format=%Y-%m-%d
        ${selected_checkout_date}=     Add Time To Date             ${current_date}           1 days            result_format=%Y-%b-%d
        ${Search_out_date} =           Get element attribute        id:check-out              attribute=value
        Should Be Equal                ${Search_out_date}           ${selected_checkout_date}


Select end date in calendar
        Wait Until Page Contains Element    id:search-input
        Input Text                          id:search-input              London
        Click Element                       id:check-in
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        mouse over                          css:div#ui-datepicker-div a.ui-datepicker-next
        Click Element                       css:div#ui-datepicker-div a.ui-datepicker-next
        ${current_date} =                   Get Current Date               local                                  result_format=%Y-%m-%d
        ${less_A_day_withzero} =            Subtract Time From Date        ${current_date}            1 days       result_format=%d
        ${current_date_less_A_day}=         Replace String Using Regexp    ${less_A_day_withzero}     ^0           ${EMPTY}
        Mouse Over                          xpath: //*[contains(text(), "${current_date_less_A_day}")]
        Click Element                       xpath: //*[contains(text(), "${current_date_less_A_day}")]
        Click Element                       id:check-out
        Press Keys                          id:check-out                 CTRL     ENTER
        Click Element                       xpath://*[@id="search-form"]/div/div/div/div[2]


Verify end date of calendar
        ${current_date} =              Get Current Date             local                     result_format=%Y-%m-%d
        ${selected_checkin_date}=      Add Time To Date             ${current_date}           364 days            result_format=%Y-%b-%d
        ${Search_in_date} =            Get element attribute        id:check-in               attribute=value
        Should Be Equal                ${Search_in_date}            ${selected_checkin_date}
        ${selected_checkout_date}=     Add Time To Date             ${current_date}           365 days            result_format=%Y-%b-%d
        ${Search_out_date} =           Get element attribute        id:check-out              attribute=value
        Should Be Equal                ${Search_out_date}           ${selected_checkout_date}


Select a random date
        Wait Until Page Contains Element    id:search-input
        Input Text                          id:search-input              London
        Click Element                       id:check-in
        Press Keys                          id:check-in                  CTRL+ARROW_DOWN     ENTER
        Click Element                       id:check-out
        Press Keys                          id:check-out                 CTRL+ARROW_DOWN     ENTER
        Click Element                       xpath://*[@id="search-form"]/div/div/div/div[2]


Verify random date is in between limit
        ${current_date} =              Get Current Date             local                                         result_format=%Y-%m-%d
        ${start_date_checkin}=         Get Current Date             local                                         result_format=%Y-%b-%d
        ${end_date_checkin}=           Add Time To Date             ${current_date}           364 days            result_format=%Y-%b-%d
        ${Selected_checkin} =          Get element attribute        id:check-in               attribute=value
        Should Be True                 '${start_date_checkin}' < '${Selected_checkin}' < '${end_date_checkin}'
        ${start_date_checkout}=        Add Time To Date             ${current_date}           1 days               result_format=%Y-%b-%d
        ${end_date_checkout}=          Add Time To Date             ${current_date}           365 days             result_format=%Y-%b-%d
        ${Selected_checkout}=          Get element attribute        id:check-out              attribute=value
        Should Be True                 '${start_date_checkout}' < '${Selected_checkout}' < '${end_date_checkout}'


End Web Test
        Close Browser
