*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
${password}
${username}
#@{company_list}           Creative Pools and Hardscape       Exterior Home Solutions of Fayetteville    J.E. Mountain Insulation LLC    County Termite & Pest Control      Security Solar    Restoration Plus    Eastern Electrical Corp.    Plumb Pro Mechanical    Richard K. Moore Professional Painting    K&M Gutter Maintenance     AMG Heating & Air Conditioning    Cohen Family Law Firm    Panda HVAC      Coastline Tree Services    Elite Mold Testing & Assessment    D & K Tree Service    Capstone Insulation LLC    A. David Zerivitz    McKee Construction & Abatement, LLC    K.C. Nummy, Inc    Southeastern Power Systems    Billy Ellis Roofing    Tru Flooring LLC    Lync Virtual Technology Solutions       J.R. Roofing & Siding Co
#@{company_list}                Bokhoven Construction      DeMar Plumbing & Electrical             Reliant, LLC
@{company_list}                     Northland Tree Enterprises    Horsham Heating and Cooling

${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               10s
${DROPDOWN_CLASS1}       dropdown-content
${LINK_TEXT1}            Report History
${DROPDOWN_CLASS}        dropdown-content
${LINK_TEXT}             Download CSV

*** Test Cases ***
Download Reports for All Companies
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    FOR    ${company}    IN    @{company_list}
        Search Company    ${company}

        Run Keyword And Ignore Error    Process Report Views
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/a
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/ul/li[2]/a/span[2]
    END
    Close Window

*** Keywords ***
Perform Login
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
    Click Button              xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Page Contains Element    xpath=//*[@id="query"]    ${TIMEOUT}

Search Company
    [Arguments]    ${company}
    Wait Until Element Is Visible    xpath=//*[@id="query"]    ${TIMEOUT}
    Input Text           xpath=//*[@id="query"]        ${company}
    Click Button         xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
    Sleep               1.5
    Log             found BL company
    Log      click report history
    Click Button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    ${TIMEOUT}     #wait on dropdown
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown

Process Report Views
    ${success}=    Set Variable    ${TRUE}
    FOR    ${index}    IN RANGE    1    7
        Log         viewing ${index} view
        Log         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[1]/span[1]
        Capture Page Screenshot
        Click Element     xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[1]
        Log          click action button ${index}
        Click Button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
        Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    ${TIMEOUT}
        Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
        Go Back
        ${is_logged_out}=    Check If Logged Out
        ${index_minus_1}=    Evaluate    ${index} - 1
        Run Keyword Unless    ${is_logged_out}    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[2]
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id="campaignHistoryActions-${index_minus_1}"]/li/form/button
        Run Keyword unless          ${visible}     Go Back Twice
        Click Button     xpath=//*[@id="campaignHistoryActions-${index_minus_1}"]/li/form/button
    END
     Run Keyword If    ${success}    Go Back Twice

Go Back To Search Page
    Go Back

Check If Logged Out
    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
    Run Keyword If    ${is_logged_out}    Perform Login
    [Return]    ${is_logged_out}

Go Back Twice
    Go Back
    Go Back

