api
generate
	self logDebugMessage: '** Generating integration test for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createIntegrationTestClass.
	self createIntegrationTestMethod