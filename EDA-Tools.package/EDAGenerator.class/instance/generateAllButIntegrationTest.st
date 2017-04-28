api
generateAllButIntegrationTest
	self generateCommand.
	self generateAggregate.
	self generateEvent.
	self generateTestHelperTrait.
	self generateDomainTest