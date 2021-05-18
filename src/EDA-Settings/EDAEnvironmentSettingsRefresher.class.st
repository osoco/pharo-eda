Class {
	#name : #EDAEnvironmentSettingsRefresher,
	#superclass : #Object,
	#traits : 'EDATSettingsChangedListener + EDATSettingBrowserHelper',
	#classTraits : 'EDATSettingsChangedListener classTrait + EDATSettingBrowserHelper classTrait',
	#category : #'EDA-Settings'
}

{ #category : #helper }
EDAEnvironmentSettingsRefresher class >> subscribeToSettingsChangedEventsIn: anEDASettingsAnnouncer [
	anEDASettingsAnnouncer
		when: EDAEnvironmentSettingsAdapterClassChanged
		do:
			[ :event | event edaApplication environmentSettingsPort: event newValue new. self refreshSettingBrowsers ]
]
