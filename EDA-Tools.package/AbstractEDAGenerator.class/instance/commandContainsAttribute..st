accessing
commandContainsAttribute: attr
	| body |
	body := commandJson at: #body.
	^ body at: attr ifPresent: [ true ] ifAbsent: [ false ]