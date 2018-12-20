lifecycle
tearDown
	super tearDown.
	"self clearPreviousEvents.
	self clearPreviousProjections.
	self clearQueues."
	self unsubscribeToEvents.
	self restoreOriginalEnvironment.
	self prepareToStopApplication.
	"self stopApplication."
	self logInfoMessage: 'Finished ' , thisContext receiver className greaseString , '>>' , thisContext receiver selector greaseString