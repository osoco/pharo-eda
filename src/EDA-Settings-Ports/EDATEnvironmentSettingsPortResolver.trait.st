Trait {
	#name : #EDATEnvironmentSettingsPortResolver,
	#traits : 'EDATPortResolver',
	#classTraits : 'EDATPortResolver classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #api }
EDATEnvironmentSettingsPortResolver >> resolvePort [
	^ self resolveSettingsPort: EDATEnvironmentSettingsPort
]
