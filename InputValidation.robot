*** Settings ***
Library  SeleniumLibrary

*** Variables ***
$url                  https://ollyolly.monday.com
${browser}                chrome





















































*** Test Cases ***
Getting Link
  Open Browser               ${url}     ${browser}
    Maximize Browser Window
    sleep               2
    input text          xpath://*[@id="user_email"]                      ${username}
    input text          xpath://*[@id="user_password"]                       ${pass}
    click button        xpath://*[@id="login-monday-container"]/div/div[2]/div/div[1]/div/div[4]/div/button
    Sleep       3



*** Keywords ***
