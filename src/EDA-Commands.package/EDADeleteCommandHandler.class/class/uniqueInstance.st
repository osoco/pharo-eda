accessing
uniqueInstance
	| result |
	result := uniqueInstance.
	result ifNil: [
		result := self new.
		result eventStore: self eventStore; eventBus: self eventBus.
		self uniqueInstance: result
	].
	^ result