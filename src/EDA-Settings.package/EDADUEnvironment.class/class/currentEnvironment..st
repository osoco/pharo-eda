accessing
currentEnvironment: aString
	| previousEnvironment |
	previousEnvironment := CurrentEnvironment.
	CurrentEnvironment := aString.
	(previousEnvironment isNil or: [ previousEnvironment = aString ])
		ifTrue: [ ^ self ].
	EDASettings resetSettings.
	self reloadSettingBrowser

