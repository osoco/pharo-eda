lifecycle
loadSettings
	(SettingBrowser allSubInstances anySatisfy: [ :w | w isRendered ]) ifFalse: [ SettingBrowser open ]