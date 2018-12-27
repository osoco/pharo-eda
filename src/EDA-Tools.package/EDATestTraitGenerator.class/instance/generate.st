api
generate
	self logDebugMessage: '** Generating test helper trait for ' , self eventName greaseString , ', version ' , self version greaseString.
	self createTestHelperTrait.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventFromArbitraryFileMethod.
	self createTestHelperBuildEventMethod.
	self createReadCommandFromFileTestHelperMethod.
	self createReadEventFromFileTestHelperMethod