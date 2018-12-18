helper
allAttributesOf: cls
	| result |
	result := OrderedCollection new.
	result addAll: cls instVarNames.
	^ result