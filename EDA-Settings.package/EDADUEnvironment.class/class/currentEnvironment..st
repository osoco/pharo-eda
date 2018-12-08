accessing
currentEnvironment: aString
	CurrentEnvironment := aString.
	self isSettingBrowserOpen ifTrue: [
		EDASettings resetSettings.
		self reloadSettingBrowser ]