setup
setup
	self isConfigured ifNil: [ self isConfigured: false ].
	self isConfigured ifTrue: [ ^ self ].
	self doSetup.
	self isConfigured: true