*EDA-Traits
instVarNamed: aString put: aValue ifAbsent: aBlock
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self
		instVarAt:
			(self class
				instVarIndexFor: aString asString
				ifAbsent: aBlock)
		put: aValue