building
buildWith: jsonDict
	| command meta body |
	meta := jsonDict at: #meta ifAbsent: [ nil ].
	body := jsonDict at: #body ifAbsent: [ nil ].
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: EDAInvalidCommandMessage ]
		ifFalse: [ [ command := (self retrieveCommandClassFromJsonDict: jsonDict) new.
			command
				commandId: (meta at: #id);
				version: (meta at: #version);
				originalTimestamp: (DateAndTime fromString: (meta at: #timestamp)).
			(command isKindOf: EDAUserCommand)
				ifTrue: [ command authorUsername: (jsonDict at: #authorUsername) ].
				self copyFromDict: body intoCommand: command.
		.
			^ command ]
				on: Exception
				do: [ :ex |
					self
						logErrorMessage:
							((WriteStream on: String new)
								nextPutAll: 'Command rejected: ';
								nextPutAll: ex greaseString;
								close;
								contents)
						andThrow: EDAInvalidCommandMessage ] ]