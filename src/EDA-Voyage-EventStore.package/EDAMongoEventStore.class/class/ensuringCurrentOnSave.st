accessing
ensuringCurrentOnSave
	ensuringCurrentOnSave ifNil: [ self ensuringCurrentOnSave: true ].
	^ ensuringCurrentOnSave