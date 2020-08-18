generated-v1
ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs
	| result |
	result := super ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs.
	result timestamp: DateAndTime now asUTC.
	^ result