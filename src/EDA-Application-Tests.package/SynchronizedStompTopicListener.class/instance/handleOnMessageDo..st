logic
handleOnMessageDo: ctx
	| proc |
	proc := [ 
		[ self eventsReady ]
		whileFalse: [ 
			Transcript
				print: 'Waiting 1.5s';
				cr;
				flush.
			(Delay forMilliseconds: 1500) wait ].
		super manageMessage: ctx
	] newProcess.
	proc priority: Processor systemBackgroundPriority.
	proc resume.
	^ self