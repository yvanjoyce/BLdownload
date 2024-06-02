from undetected_chromedriver.v2 import Chrome, ChromeOptions

class UndetectedChromedriverLibrary:

    def __init__(self):
        options = ChromeOptions()
        options.add_argument("--disable-web-security")
        self.driver = Chrome(options=options)

    # Define other keywords and methods here
