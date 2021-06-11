Trait {
	#name : #EDATTestEvent,
	#category : #'EDA-TestSupport'
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
	| result |
	result := myAttr isCollection and: [ otherAttr isCollection ].
	result ifTrue: [ result := myAttr asOrderedCollection = otherAttr asOrderedCollection  ].
	^ result
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
