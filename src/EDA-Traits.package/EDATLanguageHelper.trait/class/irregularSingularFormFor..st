helper
irregularSingularFormFor: aNoun
	| mapping |
	mapping := Dictionary new.
	mapping at: 'buses' put: 'bus'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]