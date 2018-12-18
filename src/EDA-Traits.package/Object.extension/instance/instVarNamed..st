*EDA-Traits
instVarNamed: aString
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString ifAbsent: [ self error: 'no such inst var' ]