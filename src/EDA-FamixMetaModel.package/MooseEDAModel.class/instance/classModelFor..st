as yet unclassified
classModelFor: aClass
	^ self allModelClasses
		detect: [ :classModel | classModel smalltalkClass = aClass ]