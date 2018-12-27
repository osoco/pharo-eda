event handling
handleDeleteCommand: aCommand
	| result |
	self id ifNil: [ (EDAAggregateRootDoesNotExist forClass: self class) signal ].
	result := self buildDeleteCommandResultEvent.
	result ifNotNil: [ :r |
		r id: self id.
		r commandId: aCommand commandId.
		r version: 1.
		r timestamp: DateAndTime new asUTC ].
	^ result