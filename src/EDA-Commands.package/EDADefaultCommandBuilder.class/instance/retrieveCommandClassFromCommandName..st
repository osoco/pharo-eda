building
retrieveCommandClassFromCommandName: commandName
	| result |
	result := commandDictionary at: commandName ifAbsent: [ nil ].
	result
		ifNil: [ self
				logErrorMessage: (String streamContents: [ :s | s nextPutAll:
					self class greaseString ; nextPutAll: ' does not currently know how to build '
						; nextPutAll: commandName greaseString ; nextPutAll: ' commands. Check '
						; nextPutAll: self class greaseString ; nextPutAll: '>>initializeCommandMappings' ])
				andThrow: EDACommandError ].
	^ result