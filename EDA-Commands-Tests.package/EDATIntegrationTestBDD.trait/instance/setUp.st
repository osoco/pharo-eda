initialization
setUp
	super setUp.
	self showTranscript.
	self logInfoMessage: 'Running ', thisContext receiver className, '#' , thisContext receiver selector.
	self setUpCurrentEnvironment.
	self ensureSettingsLoaded.
	self prepareToLaunchApplication.
	self setUpApplication.
	self launchApplication