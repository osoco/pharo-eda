class-factory
newClassName: nameString
	^ self
		newSubclassNamed: nameString
		of: Object
		instanceVariableNames: ''
		classVariableNames: ''