accessing
currentEnvironment: aString
	| previousEnvironment |
	previousEnvironment := self currentEnvironment.
	CurrentEnvironment := aString.
	(previousEnvironment isNil or: [ previousEnvironment = aString ])
		ifTrue: [ ^ self ].
	EDASettings resetSettings.
	self reloadSettingBrowser

