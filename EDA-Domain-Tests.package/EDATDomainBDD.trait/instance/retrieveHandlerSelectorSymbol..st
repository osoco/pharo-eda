as yet unclassified
retrieveHandlerSelectorSymbol: aCommand
	self flag: #TODO. "Use the pragma instead"
	^ ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol
