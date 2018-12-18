code generation - test trait
createTestHelperTrait
	| trait |
	trait := self retrieveTestHelperTraitName asSymbol.
	^ Trait named: trait uses: #() category: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate)