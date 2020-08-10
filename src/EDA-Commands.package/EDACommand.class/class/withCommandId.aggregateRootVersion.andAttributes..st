meta
withCommandId: theCommandId aggregateRootVersion: theVersion andAttributes: theAttributes
	| result |
	result := self new.
	result commandId: theCommandId.
	result aggregateRootVersion: theVersion.
	^ result