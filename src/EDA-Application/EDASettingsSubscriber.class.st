Class {
	#name : #EDASettingsSubscriber,
	#superclass : #Object,
	#category : #'EDA-Application'
}

{ #category : #setup }
EDASettingsSubscriber >> onEnvironmentSettingsPortChanged: anEvent on: anEDAApplication [
	self refreshSettingBrowsers
]

{ #category : #setup }
EDASettingsSubscriber >> onEnvironmentSettingsResolverPortChanged: anEvent on: anEDAApplication [
	anEDAApplication environmentSettingsPort: anEvent adapter
]

{ #category : #setup }
EDASettingsSubscriber >> refreshSettingBrowsers [
	self currentWorld submorphs
		select: [ :w | w model class = SettingBrowser ]
		thenCollect: [ :w | w delete. SettingBrowser open ]
]

{ #category : #setup }
EDASettingsSubscriber >> setupAnnouncer: anAnnouncer application: anEDAApplication [
	anAnnouncer
		ifNotNil: [ :announcer | 
			announcer
				when: EDAEnvironmentSettingsPortChanged
				do:
					[ :event | self onEnvironmentSettingsPortChanged: event on: anEDAApplication ] ;
				when: EDAEnvironmentSettingsResolverPortChanged
				do:
					[ :event | self onEnvironmentSettingsResolverPortChanged: event on: anEDAApplication ] ]
]
