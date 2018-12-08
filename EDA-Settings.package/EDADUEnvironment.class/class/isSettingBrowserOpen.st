helper
isSettingBrowserOpen
	^ (World submorphs anySatisfy: [ :w | w model printString = 'a SettingBrowser' ]) 