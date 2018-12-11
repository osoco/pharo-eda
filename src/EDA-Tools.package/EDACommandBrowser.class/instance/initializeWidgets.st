as yet unclassified
initializeWidgets
	list := self newList.
	list items: ((EDACommand allSubclasses select: [ :commandClass | (commandClass name beginsWith: 'EDA') not ]) sorted: [ :a :b | a name < b name ]).
	self focusOrder add: list