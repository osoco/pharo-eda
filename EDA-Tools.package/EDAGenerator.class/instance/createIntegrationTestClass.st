code generation - integration test
createIntegrationTestClass
	| cls |
	cls := (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol.
		 ^ (self class environment at: (self appName , 'ApplicationIntegrationTestCase') asSymbol)
				subclass: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Application-Tests-' , self aggregate capitalized