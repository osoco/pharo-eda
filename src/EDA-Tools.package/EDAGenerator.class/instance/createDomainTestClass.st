code generation - domain test
createDomainTestClass
	| cls |
	cls := (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol.
	(self containsAnyDisableRegenerationMethod: cls)
		ifFalse: [ ^ BabyMock2TestCase
				subclass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol
				uses: EDATDomainBDD + (Smalltalk at: (self appName , 'T' , self aggregate capitalized , 'TestHelper') asSymbol)
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate ) ]