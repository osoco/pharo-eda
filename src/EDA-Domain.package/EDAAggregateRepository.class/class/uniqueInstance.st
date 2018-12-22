setup
uniqueInstance
	| result |
	result := uniqueInstance.
	result
		ifNil: [ result := self new.
			self uniqueInstance: result ].
	result eventStore ifNil: [ result eventStore: self eventStore ].
	^ result