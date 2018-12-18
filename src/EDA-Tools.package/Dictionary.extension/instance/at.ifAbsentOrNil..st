*EDA-Tools
at: key ifAbsentOrNil: aBlock
	"Answer the value associated with the key or, if key isn't found or its value is null,
	answer the result of evaluating aBlock."

	^((array at: (self findElementOrNil: key))
			ifNil: [aBlock]
			ifNotNil: [:assoc | assoc value ifNil: [ aBlock ] ifNotNil: [ assoc ]]) value.