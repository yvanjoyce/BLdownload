from selenium import webdriver
from robot.libraries.BuiltIn import BuiltIn

def create_chrome_driver_with_debugger_address(debugger_address):
    options = webdriver.ChromeOptions()
    options.add_experimental_option("debuggerAddress", debugger_address)
    
    driver = webdriver.Chrome(options=options)

    # Return the driver to be used in Robot Framework
    return driver

def register_chrome_driver_with_debugger_address(debugger_address):
    driver = create_chrome_driver_with_debugger_address(debugger_address)
    selenium_library = BuiltIn().get_library_instance('SeleniumLibrary')
    selenium_library.register_driver(driver, alias='ChromeWithDebuggerAddress')
