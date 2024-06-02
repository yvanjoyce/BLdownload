*** Settings ***
Library         SeleniumLibrary
Library    CustomChromeOptions.py


*** Variables ***
        ${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
        ${browser}              chrome
        ${DEBUGGER_ADDRESS}          localhost:9988
#
https://www.cleansweepcoatings.com
www.kurcoconstruction.com

waterheaterllc
www.hotwaterheaterservices.com

www.alternativeedgecurbing.com
www.andrewglassllc.com
www.reusserrapidrooter.com
www.wirenutselectricalstl.com
www.superiorplantscapes.com
www.wilderremodels.com
www.dolanheatingandair.com

measuredvaldev
www.measuredvalues.com
www.coconstructionconsultants.com

www.edgelectric.com
www.eec-sc.com

supremeartillc
www.supremeartificialturf.com
www.omnijr.com
www.taylorhvac.com
www.a6roofing.com
        ${FIRST_NAME}    olly olly test
        ${LAST_NAME}    testing
        ${EMAIL}    yvanjoyce.carreo@gmail.com
        ${MESSAGE}    test form only
        ${PHONE_NUMBER}    090909909
        ${SUBMIT_BUTTON_XPATH}    //input[@class="wpcf7-form-control wpcf7-submit has-spinner btn" and @type="submit" and @value="Submit"]

*** Test Cases ***
Fill Form And Submit
    [Documentation]    Test case to fill the form and submit
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Log    Scrolling to the section
    Scroll Element Into View    xpath:/html/body/div[1]/div/div/section[10]/div/div/div[2]

    Log    Waiting until first name field is visible
    Wait Until Element Is Visible    xpath://*[@id="field-first-name"]

    Log    Inputting first name
    Input Text    xpath://*[@id="field-first-name"]    ${FIRST_NAME}

    Log    Inputting last name
    Input Text    xpath://*[@id="field-last-name"]    ${LAST_NAME}

    Log    Inputting email
    Input Text    xpath://*[@id="field-email"]    ${EMAIL}

    Log    Inputting message
    Input Text    xpath://*[@id="field-message"]    ${MESSAGE}

    Log    Inputting phone number
    Input Text    xpath://*[@id="field-phone-number"]    ${PHONE_NUMBER}

    Log    Clicking the submit button
    Click Element    xpath:${SUBMIT_BUTTON_XPATH}

    Log    Form submitted

    [Teardown]    Close Browser


*** Test Cases ***
automate test CF lead
     Open Browser               ${url}     ${browser}


*** Keywords ***
