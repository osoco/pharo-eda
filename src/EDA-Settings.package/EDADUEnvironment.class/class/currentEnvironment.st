accessing
currentEnvironment
	| aux |
	aux := CurrentEnvironment.
	(aux isNil or: [ aux isEmpty ]) ifTrue: [ aux := super currentEnvironment ].
	(aux isNil or: [ aux isEmpty ]) ifTrue: [ aux := 'development' ].
	self currentEnvironment: aux.
	^ CurrentEnvironment
