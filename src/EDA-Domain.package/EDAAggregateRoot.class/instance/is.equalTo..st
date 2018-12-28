helper
is: aString equalTo: anotherString
	^ (self normalize: aString) = (self normalize: anotherString)