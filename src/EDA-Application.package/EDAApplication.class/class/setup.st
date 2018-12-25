setup
setup
	self isConfigured
		ifFalse: [ self doSetup.
			self isConfigured: true ]