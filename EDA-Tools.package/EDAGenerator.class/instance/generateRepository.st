api
generateRepository
	Transcript
		print: 'Generating: Repository';
		cr.
	self createRepositoryClass.
	self createRepositoryClassAccessors.
	self createRepositorySetupEventStoreClassMethod.
	self createRepositoryUniqueInstanceGetterClassMethod.
	self createRepositoryUniqueInstanceSetterClassMethod.
	self createRepositoryFindByIdMethod