Trait {
	#name : #EDATSettingsHelper,
	#category : 'EDA-Traits'
}

{ #category : #helpers }
EDATSettingsHelper classSide >> retrieveFlattenedSettingAsDict: entryName using: env [
	"Retrieves the setting found under given name"

	| result |
	result := env ifNil: [ nil ] ifNotNil: [ :e | e at: entryName ifAbsent: [ nil ] ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]
]

{ #category : #helpers }
EDATSettingsHelper classSide >> retrieveSettingAsDict: entryName [
	"Retrieves the setting found under given name"
	^ self retrieveSettingAsDict: entryName using: (self duEnvironmentClass)

]

{ #category : #helpers }
EDATSettingsHelper classSide >> retrieveSettingAsDict: entryName using: env [
	"Retrieves the setting found under given name"

	| result |
	(entryName includes: $/)
		ifTrue: [ | tokens parent |
			tokens := '/' split: entryName.
			parent := tokens first.
			result := self retrieveFlattenedSettingAsDict: (tokens allButFirst joinUsing: '/') using: (self retrieveFlattenedSettingAsDict: parent using: env) ]
		ifFalse: [ result := self retrieveFlattenedSettingAsDict: entryName using: env ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]
]
