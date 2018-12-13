compilation-support
isMethod: aMethodName markedAsDisableRegenerationInClass: aClass
	^ (aClass methodDictionary at: aMethodName asSymbol ifAbsent: [ ^ false ]) hasPragmaNamed: 'disable_regeneration'