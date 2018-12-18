accessing
delete
	self flag: #TODO. "Find out why initialize doesn't get called for EDAEventSourcingEvents"
	delete ifNil: [ self initialize ].
	^ delete