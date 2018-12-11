event handling
handleDeleteCommand: aCommand
	| result |
	self id ifNil: [ (EDAAggregateRootDoesNotExist forClass: self class) signal ].
	result := EDADeleteCommandResultEvent new.
	result aggregateRootClass: self class name.
	result id: self id.
	result commandId: aCommand commandId.
	result version: 1.
	result timestamp: DateAndTime new asUTC.
	^ result