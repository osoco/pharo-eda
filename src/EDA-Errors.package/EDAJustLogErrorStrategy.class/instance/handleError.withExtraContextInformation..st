error handling
handleError: anException withExtraContextInformation: aDictionary
	| event projection |
	event := aDictionary at: #event ifAbsent: nil.
	projection := aDictionary at: #projection ifAbsent: nil.
	projection
		ifNil: [ | projections |
			projections := aDictionary
				at: #projections
				ifAbsent: OrderedCollection new.
			self
				logWarningMessage:
					(String streamContents: [ :s | s nextPutAll: 'Projection of event '; nextPutAll: event greaseString; nextPutAll: ' in projections '
						; nextPutAll: projections greaseString; nextPutAll: ' failed with error '
						; nextPutAll: anException description ])]
		ifNotNil: [ :arg |
			self
				logWarningMessage: (String streamContents: [ :s | s nextPutAll:
					'Projection of event '; nextPutAll: event greaseString; nextPutAll: ' in projection '
						; nextPutAll: projection greaseString; nextPutAll: ' failed with error '
						; nextPutAll: anException description ] )].
	^ false