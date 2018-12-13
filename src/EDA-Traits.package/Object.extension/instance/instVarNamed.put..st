*EDA-Traits
instVarNamed: aString put: aValue
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString put: aValue ifAbsent: [ self error: 'no such inst var' ]