*** Settings ***
Library    SeleniumLibrary
Library  headless_chrome.py

*** Variables ***
${HEADLESS_OPTIONS}  --headless --disable-gpu --no-sandbox
${URL_1}    https://www.kineticsxcavating.com/
${URL_2}    https://www.landscaperforest.com/
${URL_3}    https://elevatedro1dev.wpenginepowered.com/
${URL_4}    https://www.bandbss.com/
${URL_5}    https://www.timwaltersenterprises.com/
${URL_6}    https://www.gulfsideconstructionllcac.com/
${URL_7}    https://www.connectionconstructionoc.com/
${URL_8}    https://www.bmgdemolition.com/
${URL_9}    https://www.brilliantrayspainting.com/
${URL_10}    https://www.tennantremodeling.com/
${URL_11}    https://www.boswelloutdoorservicesga.com/
${URL_12}    https://www.gaallaboutmyroof.com/
${URL_13}    https://www.5-starmechanical.com/
${URL_14}    https://www.gomezconstructionnv.com/
${URL_15}    https://www.topnotchairtn.com/



${FIRST_NAME}    olly olly test
${LAST_NAME}    testing
${EMAIL}    yvanjoyce.carreo@gmail.com
${MESSAGE}    test form only
${PHONE_NUMBER}    090909909
${SUBMIT_BUTTON_XPATH}    //input[@class="wpcf7-form-control wpcf7-submit has-spinner btn" and @type="submit" and @value="Submit"]

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

*** Keywords ***
Fill Form And Submit
    [Arguments]       ${URL}
    [Documentation]    Test case to fill the form and submit on a single URL
    ${options}=    Get Headless Chrome Options
    Open Browser    ${URL}    Chrome    options=${options}
    Maximize Browser Window

    ${form_filled}=    Set Form Values
    Run Keyword Unless    ${form_filled}    Return From Keyword    ${FALSE}

    ${success}=    Submit Form
    [Teardown]    Close Browser
    [Return]    ${success}

Set Form Values
    [Documentation]    Set form values
    Input Text    xpath=//*[@id="field-first-name"] | //*[@id="firstname"]    ${FIRST_NAME}
    Input Text    xpath=//*[@id="field-last-name"] | //*[@id="lastname"]    ${LAST_NAME}
    Input Text    xpath=//*[@id="field-email"] | //*[@id="Emailaddress"]    ${EMAIL}
    Input Text    xpath=//*[@id="field-message"] | //*[@id="Howcanwehelp"]    ${MESSAGE}
    Input Text    xpath=//*[@id="field-phone-number"] | //*[@id="PhoneNumber"]    ${PHONE_NUMBER}
    [Return]    ${TRUE}

Submit Form
    [Documentation]    Submit form
    ${submit_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=${SUBMIT_BUTTON_XPATH}
    Run Keyword If    ${submit_button_visible}
    ...    Click Element    xpath=${SUBMIT_BUTTON_XPATH}
    ...    ELSE IF    ${submit_button_visible}
    ...    Click Element    xpath=/html/body/div[1]/div/div/section[10]/div/div/div[2]/div/div/form/div[3]/input
    ...    ELSE IF    ${submit_button_visible}
    ...    Click Element    xpath=/html/body/div[1]/div/div/section[8]/div/div[1]/div[2]/div/div/form/div[4]/input
    ...    ELSE IF    ${submit_button_visible}
    ...    Click Element    xpath=/html/body/div[1]/div/div[2]/section[7]/div/div/aside/div/div[2]/div/form/div[2]/div/div[2]/input
    ...    ELSE
    ...    Log    Submit button not found
    [Return]    ${submit_button_visible}

#
#*** Test Cases ***
#Fill Form On Multiple Sites And Submit
#    [Documentation]    Test form submission on multiple sites
#    FOR  ${index}  IN RANGE  5  11
#        ${URL}=    Set Variable    ${URL_${index}}
#        Fill Form And Submit    ${URL}
#    END
#
#*** Keywords ***
#Scroll Element Into View If Visible
#    [Arguments]    @{xpaths}
#    FOR    ${xpath}    IN    @{xpaths}
#            ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${xpath}
#            Run Keyword If    '${visible}' == 'True'    Scroll Element Into View    ${xpath}
#    END
#
#Fill Form And Submit
#    [Arguments]       ${URL}
#    [Documentation]    Test case to fill the form and submit on a single URL
#    ${options}=  Get Headless Chrome Options
#    Open Browser    ${URL}    Chrome         options=${options}
#    sleep       2
#    Maximize Browser Window
#
#    Log    Scrolling to the section
#    Scroll Element Into View If Visible    xpath:/html/body/div[1]/div/div/section[10]/div/div/div[2]    xpath:/html/body/div[1]/div/div/section[8]/div/div/div[2]
#
#    Log    Waiting until first name field is visible
#    Wait Until Element Is Visible    xpath:/html/body/div[1]/div/div/section[8]/div/div[1]/div[2]/div          10s
#
#    Log    Inputting first name
#    Input Text  xpath=//*[@id="field-first-name"] | //*[@id="firstname"]  ${FIRST_NAME}
#
#    Log    Inputting last name
#    Input Text    xpath://*[@id="field-last-name"] | //*[@id="lastname"]   ${LAST_NAME}
#
#    Log    Inputting email
#    Input Text  xpath=(//*[@id="field-email"] | //*[@id="Emailaddress"])  ${EMAIL}
#
#    Log    Inputting message
#    Input Text  xpath=(//*[@id="field-message"] | //*[@id="Howcanwehelp"])  ${MESSAGE}
#
#    Log    Inputting phone number
#    Input Text  xpath=(//*[@id="field-phone-number"] | //*[@id="PhoneNumber"])  ${PHONE_NUMBER}
#
#    Log  Clicking the submit button
#    ${submit_button_visible} =  Run Keyword And Return Status  Element Should Be Visible  xpath:${SUBMIT_BUTTON_XPATH}
#    Run Keyword If  ${submit_button_visible}
#    ...  Click Element  xpath:${SUBMIT_BUTTON_XPATH}
#    ...  ELSE IF  ${submit_button_visible}
#    ...  Run Keyword And Return Status  Element Should Be Visible  xpath:/html/body/div[1]/div/div/section[10]/div/div/div[2]/div/div/form/div[3]/input
#    ...  Click Element  xpath:/html/body/div[1]/div/div/section[10]/div/div/div[2]/div/div/form/div[3]/input
#    ...  ELSE IF  ${submit_button_visible}
#    ...  Click Element  xpath:/html/body/div[1]/div/div/section[8]/div/div[1]/div[2]/div/div/form/div[4]/input
#    ...  ELSE
#    ...  Log  Submit button not found
#    Sleep  4
#    [Teardown]    Close Browser
