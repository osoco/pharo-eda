setup
setup
	self isConfigured
		ifTrue: [ ^ self ].
	self doSetup.
	self isConfigured: true