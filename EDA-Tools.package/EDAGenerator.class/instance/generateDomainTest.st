api
generateDomainTest
	Transcript print: 'Generating: Domain Test'; cr.

	self createDomainTestClass.
	self createDomainTestMethod.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventMethod.
	self createDomainTestEventClass.
	self createTestEventBuildEventClassMethod.
	self createTestHelperBuildEventClassMethod.
	self createTestHelperBuildEventMethod.
	self createDomainTestEventEqualsMethod.
	self createTestHelperBuildEventMethod