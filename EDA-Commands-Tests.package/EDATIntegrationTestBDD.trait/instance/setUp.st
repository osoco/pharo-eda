initialization
setUp
	super setUp.
	self logInfoMessage: 'Running ' , thisContext receiver className greaseString , '>>' , thisContext receiver selector greaseString.
	self setUpCurrentEnvironment.
	self ensureSettingsLoaded.
	self prepareToLaunchApplication.
	self setUpApplication.
	self application eventStore repository resolver debug: true.
	self launchApplication