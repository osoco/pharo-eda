protected
doGenerate
	self createRepositoryClass.
	self createRepositoryClassAccessors.
	self createRepositorySetupEventStoreClassMethod.
	self createRepositoryUniqueInstanceGetterClassMethod.
	self createRepositoryUniqueInstanceSetterClassMethod.
	self createRepositoryFindByIdMethod