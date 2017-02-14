test - fixture
setUp
	self flag: #TODO. "temporal hack to force the Setting framework to load config"
	EDAProjectionMongoRepository host ifNil: [ SettingBrowser open ].
	self setUpCurrentEnvironment.
	self setUpProjectionRepository.
	self injectPragmaIntoTestProjection.