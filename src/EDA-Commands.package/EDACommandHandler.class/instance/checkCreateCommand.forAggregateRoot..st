handling
checkCreateCommand: aCommand forAggregateRoot: anAggregateRoot
	aCommand isCreate
		ifTrue: [ aCommand aggregateRootVersion = 0
				ifFalse: [ self
						logWarningMessage:
							'Received create command with aggregate root version '
								, aCommand aggregateRootVersion greaseString.
					aCommand aggregateRootVersion: 0 ] ].
	(aCommand isCreate not and: [ anAggregateRoot brandNew ])
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: anAggregateRoot class greaseString;
								nextPutAll: ' with id ';
								nextPutAll: aCommand aggregateRootId greaseString;
								nextPutAll: ' does not exist in tenant ';
								nextPutAll: aCommand tenant ])
				andThrow: EDAInvalidCommandMessage ]