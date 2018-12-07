*EDA-Settings
currentEnvironment: aString
	CurrentEnvironment := aString.
	EDASettings resetSettings.
	self reloadSettingBrowser 