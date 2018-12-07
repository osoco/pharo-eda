regex logic
dictAt: key for: aValue andTestCase: aTestCase
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ (aValue isKindOf: Array) ifTrue: [ RegexJsonArray newFrom: aValue andTestCase: aTestCase ] ifFalse: [ Dictionary with: '(.*)' -> '(.*)' ] ]