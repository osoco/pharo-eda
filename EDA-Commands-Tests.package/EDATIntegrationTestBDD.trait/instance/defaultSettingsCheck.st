lifecycle
defaultSettingsCheck
	self flag: #TODO.	"Very ugly hack to force the Settings framework to load config before run the tests."
	self loadSettings