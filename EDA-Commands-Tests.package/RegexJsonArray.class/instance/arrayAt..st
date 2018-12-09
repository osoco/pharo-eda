accessing
arrayAt: index
	"Answer the element at given index."

	| value result |
	value := self at: index.
	(value isKindOf: Array)
		ifTrue: [ result := value ]
		ifFalse: [ result := #(value) ].
	^ result