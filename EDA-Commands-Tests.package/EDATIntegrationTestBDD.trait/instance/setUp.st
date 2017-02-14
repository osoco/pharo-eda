as yet unclassified
setUp
	self showTranscript.
	Transcript clear; print: 'Running ', thisContext receiver className, '#', thisContext receiver selector; cr; flush.
	self setUpCurrentEnvironment.
	self ensureSettingsLoaded.
	self prepareToLaunchApplication.
	self setUpApplication.
	self launchApplication