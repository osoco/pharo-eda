event handling
handleDeleteCommand: aCommand
	| result |
	self id
		ifNil:
			[ self logErrorMessage: 'id is missing' andThrow: EDAInvalidCommandMessage ].
	result := self buildDeleteCommandResultEvent.
	result
		ifNotNil: [ :r |
			r id: self id.
			r commandId: aCommand commandId.
			r version: 1.
			r timestamp: DateAndTime new asUTC ].
	^ result