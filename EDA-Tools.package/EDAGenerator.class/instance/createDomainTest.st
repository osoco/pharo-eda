code generation - domain test
createDomainTest
	| cls |
	cls := (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol.
	(self containsAnyDisableRegenerationMethod: cls)
		ifFalse: [ ^ TestCase
				subclass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol
				uses: EDATDomainBDD + (	Smalltalk at: self retrieveTestHelperTraitName asSymbol)
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate) ]