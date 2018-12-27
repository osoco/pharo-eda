code generation
retrieveTestHelperTraitName
	^ self appName , 'T' , (self toCamelCase: self aggregate ) , 'TestHelper'