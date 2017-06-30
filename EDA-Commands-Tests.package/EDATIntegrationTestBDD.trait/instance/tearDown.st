running
tearDown
	super tearDown.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self unsubscribeToEvents.
	self restoreCurrentEnvironment.
	self prepareToStopApplication.
	"self stopApplication."
	Transcript
		print: 'Finished ';
		print: thisContext receiver className;
		print: '#';
		print: thisContext receiver selector;
		cr;
		flush