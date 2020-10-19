event handling
handleDeleteCommand: aCommand
	| result |
	self id
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: aCommand class greaseString;
								nextPutAll: ' rejected: id is nil' ])
				andThrow: EDAInvalidCommandMessage  ].
	result := self buildDeleteCommandResultEvent.
	result
		ifNotNil: [ :r | 
			r id: self id.
			r commandId: aCommand commandId.
			r version: 1.
			r timestamp: DateAndTime new asUTC ].
	^ result