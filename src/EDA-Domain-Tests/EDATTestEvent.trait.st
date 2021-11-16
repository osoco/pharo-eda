Trait {
	#name : #EDATTestEvent,
	#category : #'EDA-Domain-Tests'
}

{ #category : #helper }
EDATTestEvent >> attribute: myAttr matches: otherAttr [
	^ myAttr = otherAttr
				or: [ (self isAnything: myAttr) or: [ self isAnyTimestamp: myAttr ] ]
]

{ #category : #helper }
EDATTestEvent >> attribute: myAttr named: attrName matches: otherAttr [
	^ myAttr = otherAttr
		or: [ (self class isEventGenerated: attrName)
				or: [ (self isAnything: myAttr)
						or: [ (self isAnyTimestamp: myAttr)
								or: [ (self bothAreCollections: myAttr andTheirContentsMatch: otherAttr) or: [ self bothAreDictionaries: myAttr andTheirContentsMatch: otherAttr ] ] ] ] ]
]

{ #category : #helper }
EDATTestEvent >> bothAreCollections: myAttr andTheirContentsMatch: otherAttr [
	| anOrderedCollection otherOrderedCollection |
	(myAttr isCollection and: [ otherAttr isCollection ]) ifFalse: [ ^ false ].
	anOrderedCollection := myAttr asOrderedCollection.
	otherOrderedCollection :=  otherAttr asOrderedCollection.
	(anOrderedCollection size) = otherOrderedCollection size ifFalse: [ ^ false ].
	anOrderedCollection withIndexDo:
		[ :each :index |
		(self object: each matches: (otherOrderedCollection at: index)) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #helper }
EDATTestEvent >> bothAreDictionaries: myAttr andTheirContentsMatch: otherAttr [
	| result |
	result := myAttr isDictionary and: [ otherAttr isDictionary ].
	result
		ifTrue:
			[ result := myAttr asDictionary = otherAttr asDictionary ].
	^ result
]

{ #category : #helper }
EDATTestEvent >> isAnyTimestamp: attr [
	^ attr = '1970-01-01T00:00:00'
]

{ #category : #helper }
EDATTestEvent >> isAnything: attr [
	^ attr = '<ANYTHING>'
]

{ #category : #helper }
EDATTestEvent >> object: anObject matches: otherObject [
	^ (self isAnything: anObject)
	or: [ (self isAnything: otherObject)
	or: [ (self isAnyTimestamp: anObject)
	or: [ (self isAnyTimestamp: otherObject)
	or: [ (anObject = otherObject)
	or: [ (self bothAreCollections: anObject andTheirContentsMatch: otherObject) 
	or: [ self bothAreDictionaries: anObject andTheirContentsMatch: otherObject ] ] ] ] ] ]
]
