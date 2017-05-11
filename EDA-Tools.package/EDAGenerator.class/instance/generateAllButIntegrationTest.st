api
generateAllButIntegrationTest
	self generateCommand.
	self generateAggregate.
	self generateEvent.
	self generateRepository.
	self generateErrors.
	self generateTestHelperTrait.
	self generateDomainTest