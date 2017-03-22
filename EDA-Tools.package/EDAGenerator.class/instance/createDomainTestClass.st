compilation
createDomainTestClass
	| cls |
	cls := (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol.
	(self containsAnyDisableRegenerationMethod: cls) ifFalse: [ 
	^ TestCase
		subclass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol
		uses: EDATDomainBDD
		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Domain-Tests-' , self aggregate capitalized ]