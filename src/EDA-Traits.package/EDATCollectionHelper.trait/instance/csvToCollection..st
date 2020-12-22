removing
csvToCollection: aString
	| result |
	result := OrderedCollection new.
	aString splitOn: ',' do: [ :s | result add: s trim ].
	^ result