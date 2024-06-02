*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}               chrome
${password}              76230e7c
${username}              mariel.mojares@ollyolly.com
${company_1}             Blue Steel Fabrications LLC
${company_2}             Rightquick HVACR
${company_3}             JZ Construction LLC
${company_4}             ETS Clearing and Grading INC.
${company_5}             Nephew's Pool Service LLC
${company_6}             King Construction
${company_7}             Absolute Best Lawncare LLC
${company_8}             Mercury Home Services, LLC
${company_9}             Maple Leaf Lawns
${company_10}            Flat Roof Group, Inc.
${company_11}            Cape Home Remodel
${company_12}            Marty's Tree Services
${company_13}            Indigo Landscaping and Construction, Inc.
${TIMEOUT}               7s
*** Test Cases ***
Fill Form On Multiple Sites And Submit
    [Documentation]    Test form submission on multiple sites
    FOR  ${index}  IN RANGE  1  10
        ${URL}=    Set Variable    ${URL_${index}}
        ${success}=    Run Keyword And Return Status    Fill Form And Submit    ${URL}
        Run Keyword If    not ${success}
        ...    Log    Failed to submit form for URL: ${URL}    WARN
        ...    Continue For Loop If    ${TRUE}
    END

Check Companies Existence
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    FOR  ${index}  IN RANGE  1  13
        ${company_variable}=    Evaluate    ${{'company_' + str(index)}}
        ${company}=    Get Variable Value    ${company_variable}
        Log    Checking company: ${company}
        Log In
        Input Text    xpath=//*[@id="query"]    ${company}
        Click Button    xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
        Sleep    2
        ${exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button    ${TIMEOUT}
        Run Keyword If    ${exists}
        ...    Log    Company exists: ${company}
        ...    ELSE
        ...    Log    Company does not exist: ${company}
        Go Back
    END


    Close Window

*** Keywords ***
Log In
    Maximize Browser Window
    Input Text                 xpath=/html/body/div[1]/div/div[1]/form/input[1]     ${username}
    Input Text                 xpath=/html/body/div[1]/div/div[1]/form/input[2]     ${password}
    Click Button               xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Element Is Visible         xpath=//*[@id="query"]      ${TIMEOUT}

Log Element HTML
    [Arguments]    ${xpath}
    ${element}=    Get WebElement    ${xpath}
    ${outer_html}=    Execute JavaScript    return arguments[0].outerHTML;    ${element}
    Log    ${outer_html}
