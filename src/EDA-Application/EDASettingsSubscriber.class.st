Class {
	#name : #EDASettingsSubscriber,
	#superclass : #Object,
	#traits : 'EDATSettingBrowserHelper',
	#classTraits : 'EDATSettingBrowserHelper classTrait',
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
EDASettingsSubscriber >> onEventStoreSettingsPortChanged: anEvent on: anEDAApplication [
	self refreshSettingBrowsers
]

{ #category : #setup }
EDASettingsSubscriber >> onEventStoreSettingsResolverPortChanged: anEvent on: anEDAApplication [
	anEDAApplication eventStoreSettingsPort: anEvent adapter
]

{ #category : #setup }
EDASettingsSubscriber >> setupAnnouncer: anAnnouncer application: anEDAApplication [
	anAnnouncer
		ifNotNil: [ :announcer | 
			announcer
				when: EDAEnvironmentSettingsPortChanged
					do:
						[ :event | self onEnvironmentSettingsPortChanged: event on: anEDAApplication ];
				when: EDAEnvironmentSettingsResolverPortChanged
					do: [ :event | 
					self
						onEnvironmentSettingsResolverPortChanged: event
						on: anEDAApplication ];
				when: EDAEventStoreSettingsResolverPortChanged
					do: [ :event | 
					self
						onEventStoreSettingsResolverPortChanged: event
						on: anEDAApplication ]
					 ]
]
