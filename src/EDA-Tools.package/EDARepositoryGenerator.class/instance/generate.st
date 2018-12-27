api
generate
	self logDebugMessage: '** Generating repository for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createRepositoryClass.
	self createRepositoryClassAccessors.
	self createRepositorySetupEventStoreClassMethod.
	self createRepositoryUniqueInstanceGetterClassMethod.
	self createRepositoryUniqueInstanceSetterClassMethod.
	self createRepositoryFindByIdMethod