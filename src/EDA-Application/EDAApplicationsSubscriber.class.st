Class {
	#name : #EDAApplicationsSubscriber,
	#superclass : #Object,
	#traits : 'EDACTSettingBrowserHelper',
	#classTraits : 'EDACTSettingBrowserHelper classTrait',
	#category : #'EDA-Application'
}

{ #category : #'event handling' }
EDAApplicationsSubscriber >> onApplicationRegistered: event [
	self refreshSettingBrowsers 
]

{ #category : #helper }
EDAApplicationsSubscriber >> setupAnnouncer: anAnnouncer [
	anAnnouncer
		ifNotNil: [ :announcer | 
			announcer
				when: EDAApplicationRegistered
				do:
					[ :event | self onApplicationRegistered: event ] ]
]
