setup
uniqueInstance
	| result |
	result := uniqueInstance.
	result
		ifNil: [ result := self new.
			result eventStore: eventStore.
			self uniqueInstance: result ].
	^ result