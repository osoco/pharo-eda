tests
testScannerCreation
	| aClass aPragma scanner |
	aClass := protocol mock: 'aClass'.
	aPragma := protocol mock: 'aPragma'.
	scanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: aPragma from: aClass.
	self assert: scanner pragma equals: aPragma.
	self assert: scanner fromClass equals: aClass