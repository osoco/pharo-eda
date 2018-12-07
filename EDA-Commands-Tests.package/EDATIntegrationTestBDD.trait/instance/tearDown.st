lifecycle
tearDown
	super tearDown.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self unsubscribeToEvents.
	self restoreCurrentEnvironment.
	self prepareToStopApplication.
	"self stopApplication."
	self application eventStore repository resolver debug: false.
	EDADUEnvironment currentEnvironment: self originalEnvironment.
	self
		logInfoMessage: 'Finished ' , thisContext receiver className greaseString , '>>' , thisContext receiver selector greaseString