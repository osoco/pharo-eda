Extension { #name : #Object }

{ #category : #'*EDA-Traits' }
Object >> instVarNamed: aString [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString ifAbsent: [ self error: 'no such inst var' ]
]

{ #category : #'*EDA-Traits' }
Object >> instVarNamed: aString ifAbsent: aBlock [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self
		instVarAt:
			(self class
				instVarIndexFor: aString asString
				ifAbsent: aBlock)
]

{ #category : #'*EDA-Traits' }
Object >> instVarNamed: aString put: aValue [
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString put: aValue ifAbsent: [ self error: 'no such inst var' ]
]

{ #category : #'*EDA-Traits' }
Object >> instVarNamed: aString put: aValue ifAbsent: aBlock [
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self
		instVarAt:
			(self class
				instVarIndexFor: aString asString
				ifAbsent: aBlock)
		put: aValue
]
