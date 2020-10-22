meta
ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs
	| result scopeKey scopeContext |
	result := self new.
	result tenant: theTenant.
	result id: theId.
	result commandId: theCommandId.
	result
		timestamp: (theAttrs at: 'timestamp' ifAbsent: [ DateAndTime now asUTC ]).
	result version: (theAttrs at: 'version' ifAbsent: [ self latestVersion ]).
	scopeKey := theAttrs at: 'scopeKey' ifAbsent: [ nil ].
	scopeKey ifNotNil: [ :sk | result scopeKey: sk ].
	scopeContext := theAttrs at: 'scopeContext' ifAbsent: [ nil ].
	scopeContext ifNotNil: [ :s | result scopeContext: s ].
	theAttrs at: 'agent' ifPresent: [ :v | result agent: v ].
	"theAttrs at: 'dateCreated' ifPresent: [ :v | result dateCreated: v ]."
	theAttrs at: 'entityId' ifPresent: [ :v | result entityId: v ].
	^ result