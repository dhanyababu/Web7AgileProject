*** Settings ***
Library                                  SeleniumLibrary
Library                                  RequestsLibrary



*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank                    ${BROWSER}      options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                           ${URL}



Goto hotel details
        [Arguments]                             ${Search_text}
        Wait Until Page Contains                Find your dream destination                             timeout=10
        Input Text                              id:search-input                                         ${Search_text}
        Click Element                           xpath://*[@id="search-form"]/div/div/div/div[2]
        Wait Until Page Contains                See details
        Click Element                           xpath: //*[contains(text(), "See details")]


Googlemap image is displayed
        Wait Until Page Contains Element        id:largeMapLink						 timeout=10
        Element Should Be Visible               css:div.mb-3 a#largeMapLink img



Verify page contains link
       [Arguments]                             ${href_link}
       ${page_href}=                            Get Element Attribute       id:largeMapLink       attribute=href
       Should Be Equal                          ${page_href}                ${href_link}



Verifying Hypertext reference link
        [Arguments]                             ${href_link}
        Create Session	                        google	                    ${href_link}
        ${resp}=	                            Get Request     	        google      	    /
        Should Be Equal As Strings	            ${resp.status_code}	        200


Verify link is redirecting or not
        Click Image                             css:div.mb-3 a#largeMapLink img
        Select Window                           - ProjectAgileWeb7



End Web Test
        Close Browser
