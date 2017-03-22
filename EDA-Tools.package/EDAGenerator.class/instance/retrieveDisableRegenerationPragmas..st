helper
retrieveDisableRegenerationPragmas: aClass
	(self classExists: aClass asSymbol)
		ifTrue: [ ^ (Pragma allNamed: 'disable_regeneration' in: aClass asClass) collect: [ :pragma | pragma method ] ]
		ifFalse: [  ^ #() ]