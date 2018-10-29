api
generateAll
	self logInfoMessage: '** Generation started for ', self aggregate, '.'.
	self generateAllButIntegrationTest.
	self generateIntegrationTest