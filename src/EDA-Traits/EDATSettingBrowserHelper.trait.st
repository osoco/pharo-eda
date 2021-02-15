Trait {
	#name : #EDATSettingBrowserHelper,
	#category : #'EDA-Traits'
}

{ #category : #helper }
EDATSettingBrowserHelper classSide >> refreshSettingBrowsers [
	self currentWorld submorphs
		select: [ :w | w model class = SettingBrowser ]
		thenCollect: [ :w | w delete. SettingBrowser open ]
]

{ #category : #helper }
EDATSettingBrowserHelper >> refreshSettingBrowsers [
	self class refreshSettingBrowsers
]
