compilation
createIntegrationTestClass
	| cls |
	cls := (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol.
	(self containsAnyDisableRegenerationMethod: cls) ifFalse: [ 
	^ (self appName , 'ApplicationIntegrationTestCase') asClass
		subclass: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Application-Tests-' , self aggregate capitalized ]