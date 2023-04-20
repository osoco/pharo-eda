Trait {
	#name : #EDATRegexHelper,
	#category : #'EDA-Traits'
}

{ #category : #copying }
EDATRegexHelper classSide >> copyString: aString keepingContentsInAllMatchsBetweenInitialDelimiter: initialDelimiter andFinalDelimiter: finalDelimiter changingThemFor: newInitialDelimiter and: newFinalDelimiter [
	| pattern |	
	pattern := (initialDelimiter , '([^)]*)' , finalDelimiter)  asRegex.
	
	^ pattern copy: aString translatingMatchesUsing: [ :match | 
		| prefixChanged |
		prefixChanged := initialDelimiter asRegex copy: match translatingMatchesUsing: [ :preffix | newInitialDelimiter ].
		finalDelimiter asRegex copy: prefixChanged translatingMatchesUsing: [ :suffix | newFinalDelimiter ] ].
]

{ #category : #helpers }
EDATRegexHelper classSide >> replaceIn: aString allMatches: regex with: replacement [
	^ regex asRegex copy: aString replacingMatchesWith: replacement asString
]

{ #category : #helpers }
EDATRegexHelper >> replaceIn: aValue allMatches: regex with: replacement [
	^ self class replaceIn: aValue allMatches: regex with: replacement
]
