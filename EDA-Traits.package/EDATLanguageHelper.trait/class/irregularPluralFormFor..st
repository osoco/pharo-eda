helper
irregularPluralFormFor: aNoun
	| mapping |
	mapping := Dictionary new.
	mapping at: 'bus' put: 'buses'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]