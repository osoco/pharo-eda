Trait {
	#name : #EDATEnvironmentSettingsPortResolver,
	#traits : 'EDATPortResolver',
	#category : #'EDA-Settings-Ports'
}

{ #category : #api }
EDATEnvironmentSettingsPortResolver >> resolvePort [
	^ self resolveSettingsPort: EDATEnvironmentSettingsPort
]
