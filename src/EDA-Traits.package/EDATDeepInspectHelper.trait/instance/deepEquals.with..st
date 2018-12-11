comparing
deepEquals: anInstance with: anotherInstance
	| result |
	(self areArrayOrCollectionBoth: anInstance and: anotherInstance) ifTrue: [
		result := self deepEqualsArrayOrCollection: anInstance with: anotherInstance
	] ifFalse: [
		result := (anInstance class = anotherInstance class).
		result
			ifFalse: [
				result := (anInstance class isKindOf: anotherInstance class) or: [ anotherInstance class isKindOf: anInstance class ]
			].
		result ifTrue: [
			| myVarNames |
			myVarNames := anInstance class allInstVarNames.
			result := myVarNames = (anotherInstance class allInstVarNames)
		].
		result ifTrue: [
			result :=
				(anInstance class allInstVarNames reject: [ :varName |
					| myVar hisVar |
					myVar := (anInstance instVarNamed: varName).
					hisVar := (anotherInstance instVarNamed: varName).
					(self areDictionariesBoth: myVar and: hisVar)
						ifTrue: [
							self deepEqualsDictionary: myVar with: hisVar
						] ifFalse: [
							(self areArrayOrCollectionBoth: myVar and: hisVar)
								ifTrue: [
									self deepEqualsArrayOrCollection: myVar with: hisVar
								] ifFalse: [
									myVar = hisVar
								]
						]
				]) isEmpty
			]
		].
	^ result