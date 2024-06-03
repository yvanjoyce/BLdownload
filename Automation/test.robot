*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}              https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}          chrome
${password}         #enter password
${username}         #enter email
${company}          The Right Home Inspection Services
${REL_XPATH}        xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}      id=rememberMe
${TIMEOUT}          7s
${DROPDOWN_CLASS1}  dropdown-content
${LINK_TEXT1}       Report History
${DROPDOWN_CLASS}   dropdown-content
${LINK_TEXT}        Download CSV

*** Test Cases ***
Download report from BL
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Input Text      xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
    Input Text      xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
    Click Button    xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="query"]    ${TIMEOUT}
    Input Text      xpath=//*[@id="query"]    ${company}
    Click Button    xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
    Sleep    4
    Click Button    xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    10s
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]
    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[1]/td[4]/div/a[1]
    Click Button    xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
    Go Back
    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[1]/td[4]/div/a[2]
    Click Button    xpath=//*[@id="campaignHistoryActions-0"]/li/form/button
    Repeat Keyword    View and Archive Report    2
    Repeat Keyword    View and Archive Report    3
    Repeat Keyword    View and Archive Report    4
    Repeat Keyword    View and Archive Report    5
    Repeat Keyword    View and Archive Report    6
    Close Window

*** Keywords ***
View and Archive Report
    [Arguments]    ${index}
    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[1]
    Click Button    xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
    Go Back
    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[2]
    Click Button    xpath=//*[@id="campaignHistoryActions-${index-1}"]/li/form/button

Log Element HTML
    [Arguments]    ${xpath}
    ${element}=    Get WebElement    ${xpath}
    ${outer_html}=    Execute JavaScript    return arguments[0].outerHTML;    ${element}
    Log    ${outer_html}
