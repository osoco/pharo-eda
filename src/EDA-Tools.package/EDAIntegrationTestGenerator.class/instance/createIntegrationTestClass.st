code generation
createIntegrationTestClass
	| cls |
	cls := (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol.
	^ (self class environment at: (self appName , 'ApplicationIntegrationTestCase') asSymbol)
		subclass: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol
						uses: (Smalltalk at: (self appName , 'T' , self aggregate capitalized , 'TestHelper') asSymbol)

		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Application-Tests-' , self aggregate capitalized