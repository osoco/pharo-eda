api
generateAllButIntegrationTest
	self generateCommand.
	self generateEvent.
	self generateAggregate.
	self generateEDAApplication.
	self generateTestHelperTrait.
	self generateTestEvent.
	self generateDomainTest