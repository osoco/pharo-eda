lifecycle
tearDown
	self clearPreviousEvents.
	self clearPreviousProjections.
	self unsubscribeToEvents.
	self restoreCurrentEnvironment.
	self prepareToStopApplication.
	"self stopApplication."
	"Transcript print: 'Finished ', thisContext; cr; flush."
