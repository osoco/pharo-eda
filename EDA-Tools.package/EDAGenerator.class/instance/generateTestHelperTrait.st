api
generateTestHelperTrait
	Transcript print: 'Generating: Test Helper trait'; cr.

	self createTestHelperTrait.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventMethod.
	self createReadCommandFromFileTestHelperMethod.
	self createReadEventFromFileTestHelperMethod