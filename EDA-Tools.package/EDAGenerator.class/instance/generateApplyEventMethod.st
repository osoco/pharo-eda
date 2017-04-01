code generation - aggregate
generateApplyEventMethod
	| result eventClass |
	eventClass := self retrieveEventClassName asSymbol.
	result := self generateApplyEventMethodNameWithArg: 'anEvent' , String cr.
	self retrieveEventAttributes
		do: [ :attr | result := result , '    self ' , attr , ': anEvent ' , attr , '.' , String cr ].
	^ result