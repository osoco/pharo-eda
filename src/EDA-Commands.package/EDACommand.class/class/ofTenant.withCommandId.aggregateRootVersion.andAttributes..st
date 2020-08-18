meta
ofTenant: theTenant withCommandId: theCommandId aggregateRootVersion: theVersion andAttributes: theAttributes
	| result |
	result := self new.
	result tenant: theTenant.
	result commandId: theCommandId.
	result aggregateRootVersion: theVersion.
		result version: (theAttributes at: 'version' ifAbsent: [ 1 ]).
	theAttributes
		at: 'aggregateRootClass'
		ifPresent: [ :v | result aggregateRootClass: v ].
	^ result