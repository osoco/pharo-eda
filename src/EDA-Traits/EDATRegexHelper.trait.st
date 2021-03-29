Trait {
	#name : #EDATRegexHelper,
	#category : #'EDA-Traits'
}

{ #category : #helpers }
EDATRegexHelper classSide >> replaceIn: aString allMatches: regex with: replacement [
	^ regex asRegex copy: aString replacingMatchesWith: replacement asString
]

{ #category : #helpers }
EDATRegexHelper >> replaceIn: aValue allMatches: regex with: replacement [
	^ self class replaceIn: aValue allMatches: regex with: replacement
]
