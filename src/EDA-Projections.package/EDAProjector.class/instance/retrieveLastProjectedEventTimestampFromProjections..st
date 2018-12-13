projection retrieval
retrieveLastProjectedEventTimestampFromProjections: aProjectionCollection
	| result |
	aProjectionCollection ifEmpty: [ result := Date new ] ifNotEmpty: [ result := (aProjectionCollection collect: [ :each | each lastProjectedEvent ]) asSortedCollection last ].
	^ result