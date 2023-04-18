Trait {
	#name : #EDATLanguageHelper,
	#category : 'EDA-Traits'
}

{ #category : #helper }
EDATLanguageHelper classSide >> irregularPastTenses: aVerb [
	| result dict |
	dict := {('build' -> 'built').
	('send' -> 'sent').
	('submit' -> 'submitted')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDATLanguageHelper classSide >> irregularPluralFormFor: aNoun [
	| mapping |
	mapping := Dictionary new.
	mapping at: 'bus' put: 'buses'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]
]

{ #category : #helper }
EDATLanguageHelper classSide >> irregularPresentTenses: aVerb [
	| result dict |
	dict := {('built' -> 'build').
	('sent' -> 'send').
	('submitted' -> 'submit')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDATLanguageHelper classSide >> irregularSingularFormFor: aNoun [
	| mapping |
	mapping := Dictionary new.
	mapping at: 'buses' put: 'bus'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]
]

{ #category : #helper }
EDATLanguageHelper classSide >> nounInPlural: aNoun [
	| result |
	result := self irregularPluralFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*y$')
				ifTrue: [ (self removeSuffix: 'y' from: aNoun) , 'ies' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ aNoun ]
								ifFalse: [ aNoun , 's' ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDATLanguageHelper classSide >> nounInSingular: aNoun [
	| result |
	result := self irregularSingularFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*ies$')
				ifTrue: [ (self removeSuffix: 'ies' from: aNoun) , 'y' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ self removeSuffix: 's' from: aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ self removeSuffix: 's' from: aNoun ]
								ifFalse: [ aNoun ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #removing }
EDATLanguageHelper classSide >> removePrefix: prefix from: value [
	^ ('^' , prefix copyReplaceAll: ':' with: '\:') asRegexIgnoringCase copy: value greaseString replacingMatchesWith: ''
]

{ #category : #removing }
EDATLanguageHelper classSide >> removeSuffix: suffix from: value [
	^ ((suffix copyReplaceAll: ':' with: '\:') , '$') asRegexIgnoringCase copy: value replacingMatchesWith: ''
]

{ #category : #helper }
EDATLanguageHelper classSide >> verbInPastTense: aVerb [
	| result |
	result := self irregularPastTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*([aeiou])$')
				ifTrue: [ aVerb , 'd' ]
				ifFalse: [ aVerb , 'ed' ] ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDATLanguageHelper classSide >> verbInPresentTense: aVerb [
	| result |
	result := self irregularPresentTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*ed$')
				ifTrue: [ self removeSuffix: 'd' from: aVerb ]
				ifFalse: [ self removeSuffix: 'd' from: aVerb ] ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDATLanguageHelper >> irregularPastTenses: aVerb [
	^ self class irregularPastTenses: aVerb
]

{ #category : #helper }
EDATLanguageHelper >> irregularPluralFormFor: aNoun [
	^ self class irregularPluralFormFor: aNoun
	
]

{ #category : #helper }
EDATLanguageHelper >> irregularPresentTenses: aVerb [
	^ self class irregularPresentTenses: aVerb

]

{ #category : #helper }
EDATLanguageHelper >> irregularSingularFormFor: aNoun [
	^ self class irregularSingularFormFor: aNoun

]

{ #category : #helper }
EDATLanguageHelper >> nounInPlural: aNoun [
	^ self class nounInPlural: aNoun

]

{ #category : #helper }
EDATLanguageHelper >> nounInSingular: aNoun [
	^ self class nounInSingular: aNoun

]

{ #category : #helper }
EDATLanguageHelper >> removePrefix: prefix from: value [
	^ self class removePrefix: prefix from: value

]

{ #category : #helper }
EDATLanguageHelper >> removeSuffix: suffix from: value [
	^ self class removeSuffix: suffix from: value

]

{ #category : #helper }
EDATLanguageHelper >> verbInPastTense: aVerb [
	^ self class verbInPastTense: aVerb

]

{ #category : #helper }
EDATLanguageHelper >> verbInPresentTense: aVerb [
	^ self class verbInPresentTense: aVerb

]
