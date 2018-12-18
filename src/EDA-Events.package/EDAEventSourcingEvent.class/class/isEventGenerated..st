meta
isEventGenerated: attr
	^ self attributesWhoseValuesGetGenerated anySatisfy: [ :v | v = attr ]