code generation - test trait
createTestHelperTrait
	| trait |
	trait := self retrieveTestHelperTraitName asSymbol.
	(self containsAnyDisableRegenerationMethod: trait)
		ifFalse: [ ^ Trait named: trait uses: {} category: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate) ]