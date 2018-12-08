helper
reloadSettingBrowser
	((World submorphs select: [ :w | (w model printString = 'a SettingBrowser') ])) do: [ :w | w delete ].
	SettingBrowser open.