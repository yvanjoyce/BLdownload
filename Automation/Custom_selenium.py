from selenium import webdriver
from selenium.webdriver.chrome.options import Options


class CustomSeleniumLibrary:
    def create_custom_webdriver(self):
        options = Options()
        options.add_argument("--disable-blink-features=AutomationControlled")
        options.add_argument("--disable-infobars")
        options.add_argument("--start-maximized")

        driver = webdriver.Chrome(options=options)
        return driver
