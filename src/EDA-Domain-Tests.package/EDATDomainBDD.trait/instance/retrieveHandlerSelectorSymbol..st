helper
retrieveHandlerSelectorSymbol: aCommand
	| result |
	(aCommand isDelete)
		ifTrue: [
			result := #handleDeleteCommand:.
		] ifFalse: [
			self flag: #TODO. "Use the pragma instead"
			result := ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol
		].
	^ result
