*EDA-Projections
keysAndValuesDo: aBlock displayingProgress: aStringOrBlock every: msecs
	"Enumerate aBlock displaying progress information.
       If the argument is a string, use a static label for the process.
       If the argument is a block, evaluate it with the element to retrieve the label.
       The msecs argument ensures that updates happen at most every msecs.
       Example:
               Smalltalk allClasses
                       keysAndValuesDo:[:aClass| (Delay forMilliseconds: 1) wait]
                       displayingProgress:[:aClass| 'Processing ', aClass name]
                       every: 0."

	| size labelBlock count oldLabel lastUpdate |
	self isEmpty
		ifTrue: [ ^ self ].
	oldLabel := nil.
	count := lastUpdate := 0.
	size := self size.
	''
		displayProgressFrom: 0
		to: size
		during: [ :bar | 
			labelBlock := aStringOrBlock isString
				ifTrue: [ bar label: aStringOrBlock.
					[ :dummyItem | aStringOrBlock ] ]
				ifFalse: [ aStringOrBlock ].
			self
				keysAndValuesDo: [ :index :each | 
					| newLabel |
					"Special handling for first and last element"
					(index = 0 or: [ index + 1 = size or: [ (Time millisecondsSince: lastUpdate) >= msecs ] ])
						ifTrue: [ bar current: index.
							oldLabel = (newLabel := (labelBlock cull: index cull: each) ifNil: [ oldLabel ])
								ifFalse: [ bar label: newLabel.
									oldLabel := newLabel ].
							lastUpdate := Time millisecondClockValue ].
					aBlock value: index value: each ] ]