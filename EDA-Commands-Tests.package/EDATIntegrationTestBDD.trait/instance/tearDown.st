running
tearDown
	super tearDown.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self unsubscribeToEvents.
	self restoreCurrentEnvironment.
	self prepareToStopApplication.
	"self stopApplication."
	self logInfoMessage: 'Finished ', thisContext receiver className greaseString , '>>', thisContext receiver selector greaseString
