accessing
currentEnvironment: aString
	| previousEnvironment |
	previousEnvironment := self currentEnvironment.
	CurrentEnvironment := aString.
	(previousEnvironment = aString) ifFalse: [ 
		EDASettings resetSettings.
		self reloadSettingBrowser
	]