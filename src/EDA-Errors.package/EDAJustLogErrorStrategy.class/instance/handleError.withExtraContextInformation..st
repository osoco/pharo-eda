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
					'Projection of event ' , event greaseString , ' in projections '
						, projections greaseString , ' failed with error '
						, anException description , '.' ]
		ifNotNil: [ self
				logWarningMessage:
					'Projection of event ' , event greaseString , ' in projection '
						, projection greaseString , ' failed with error '
						, anException description , '.' ].
	^ false