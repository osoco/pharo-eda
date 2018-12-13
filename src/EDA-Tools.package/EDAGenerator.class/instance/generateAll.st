api
generateAll
	self logInfoMessage: '** Generation started for ', self aggregate greaseString , '.'.
	self generateAllButIntegrationTest.
	self generateIntegrationTest