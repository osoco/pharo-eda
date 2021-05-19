Trait {
	#name : #EDATPortResolver,
	#category : #'EDA-Settings-Ports'
}

{ #category : #logic }
EDATPortResolver >> availableAdapters: aPort [
	^ (aPort traitUsers select: [ :cls | cls accepts: self ]) sorted
]

{ #category : #logic }
EDATPortResolver >> availableCommandListenerSettingsErrorStrategyAdapters [
	^ self availableAdapters: EDATCommandListenerSettingsErrorStrategyPort
]

{ #category : #logic }
EDATPortResolver >> availableEnvironmentSettingsAdapters [
	^ self availableAdapters: EDATEnvironmentSettingsPort
]

{ #category : #accessing }
EDATPortResolver >> environmentSettingsPort [
	^ self resolveEnvironmentSettingsPort
]

{ #category : #accessing }
EDATPortResolver >> resolveEnvironmentSettingsPort [
	^ self resolvePort: EDATEnvironmentSettingsPort
]

{ #category : #api }
EDATPortResolver >> resolvePort: aPort [
	| candidates candidate |
	candidates := (self availableAdapters: aPort) sorted.
	candidate := candidates
		ifEmpty: [ nil ]
		ifNotEmpty: [ :col | col first ].
	^ candidate ifNil: [ nil ] ifNotNil: [ :c | c withApp: self ]
]
