accessing
currentEnvironment
	| aux |
	aux := CurrentEnvironment.
	aux ifNil: [ environment := super currentEnvironment. self currentEnvironment: aux ].
	^ CurrentEnvironment
