api
generate
	self logDebugMessage: '** Generating domain test for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createDomainTestClass.
	self createDomainTestMethod.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventMethod.
	self createDomainTestEventClass.
	self createTestEventBuildEventClassMethod.
	self createTestHelperBuildEventClassMethod.
	self createDomainTestEventEqualsMethod.
	self createDomainTestEventClassAggregateRootClassMethod