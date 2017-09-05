accessing
totalProjectedEvents
	| allProjectionsOfThisKind totalProjectedEvents |
	allProjectionsOfThisKind := self new selectManyWhere: Dictionary new.
	totalProjectedEvents :=
		allProjectionsOfThisKind isEmpty
			ifTrue: [ 0 ]
			ifFalse: [
				allProjectionsOfThisKind size = 1
					ifTrue: [ allProjectionsOfThisKind first numProjectedEvents ]
					ifFalse: [ (allProjectionsOfThisKind collect: [ :proj | proj numProjectedEvents ]) reduce: [ :a :b | a + b ] ]
			].
	^ totalProjectedEvents