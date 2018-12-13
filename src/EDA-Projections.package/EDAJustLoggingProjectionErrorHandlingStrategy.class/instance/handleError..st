error handling
handleError: anException
	| event projection |
	event := self context at: #event ifAbsent: nil.
	projection := self context at: #projection ifAbsent: nil.
	projection
		ifNil: [ | projections |
		projections := self context at: #projections ifAbsent: OrderedCollection new.
			self logWarningMessage: 'Projection of event ' , event greaseString , ' in projections ', projections greaseString, ' failed with error ' , anException description , '.' ]
		ifNotNil: [ self logWarningMessage: 'Projection of event ' , event greaseString , ' in projection ', projection greaseString, ' failed with error ' , anException description , '.' ].
	^ false