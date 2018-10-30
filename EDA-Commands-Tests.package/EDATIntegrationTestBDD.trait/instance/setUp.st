initialization
setUp
	super setUp.
	self showTranscript.
	self logInfoMessage: 'Running ', thisContext receiver className greaseString , '>>' , thisContext receiver selector greaseString.
	self setUpCurrentEnvironment.
	self ensureSettingsLoaded.
	self prepareToLaunchApplication.
	self setUpApplication.
	self launchApplication