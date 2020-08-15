meta
forTenant: theTenant withCommandId: theCommandId aggregateRootVersion: theVersion andAttributes: theAttributes
	| result |
	result := self new.
	result tenant: theTenant.
	result commandId: theCommandId.
	result aggregateRootVersion: theVersion.
	^ result