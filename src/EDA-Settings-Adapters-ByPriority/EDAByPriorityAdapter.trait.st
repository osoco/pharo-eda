Trait {
	#name : #EDAByPriorityAdapter,
	#category : #'EDA-Settings-Adapters-ByPriority'
}

{ #category : #logic }
EDAByPriorityAdapter >> resolveCommandListenerSettingsPort [
	^ self resolveSettingsPort: EDACommandListenerSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveEnvironmentSettingsPort [
	^ self resolveSettingsPort: EDAEnvironmentSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveEventPublisherSettingsPort [
	^ self resolveSettingsPort: EDAEventPublisherSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveEventStoreSettingsPort [
	^ self resolveSettingsPort: EDAEventStoreSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveLoggingSettingsPort [
	^ self resolveSettingsPort: EDALoggingSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveProjectionSettingsPort [
	^ self resolveSettingsPort: EDAProjectionSettingsPort
]

{ #category : #logic }
EDAByPriorityAdapter >> resolveSettingsPort: aPort [
	| candidates candidate |
	candidates := (aPort traitUsers select: [ :cls | cls accepts: self ])
		sorted.
	candidate := candidates
		ifEmpty: [ nil ]
		ifNotEmpty: [ :col | col first ].
	^ candidate ifNil: [ nil ] ifNotNil: [ :c | c withApp: self ]
]
