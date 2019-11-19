generated-v1
withAggregateId: theId commandId: theCommandId andAttributes: theAttrs

	| result | 
	result := self new.
	result id: theId.
	result commandId: theCommandId.
	result timestamp: DateAndTime now asUTC.
	result version: (theAttrs at: 'version').
	result aggregateRootVersion: (theAttrs at: 'aggregateRootVersion').

	^ result