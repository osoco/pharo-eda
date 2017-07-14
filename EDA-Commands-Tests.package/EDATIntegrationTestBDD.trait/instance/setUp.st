initialization
setUp
	super setUp.
	self showTranscript.
	Transcript
		print: 'Running ';
		print: thisContext receiver className;
		print: $#;
		print: thisContext receiver selector;
		cr.
	self setUpCurrentEnvironment.
	self ensureSettingsLoaded.
	self prepareToLaunchApplication.
	self setUpApplication.
	self launchApplication