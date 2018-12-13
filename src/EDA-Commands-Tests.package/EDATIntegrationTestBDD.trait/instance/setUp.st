initialization
setUp
	super setUp.
	self logInfoMessage: 'Running ' , thisContext receiver className greaseString , '>>' , thisContext receiver selector greaseString.
	self originalEnvironment: EDADUEnvironment currentEnvironment.
	self setUpCurrentEnvironment.
	self loadSettings.
	self prepareToLaunchApplication.
	self setUpApplication.
	self application eventStore repository resolver debug: true.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self clearQueues.
	self launchApplication