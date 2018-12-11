compilation-support
retrieveMethodsInClass: aClass withPragma: aPragma
	(self classExists: aClass asSymbol)
		ifTrue: [ ^ (Pragma
				allNamed: aPragma
				in: (self class environment at: aClass asSymbol)) collect: [ :pragma | pragma method ] ]
		ifFalse: [ ^ #() ]