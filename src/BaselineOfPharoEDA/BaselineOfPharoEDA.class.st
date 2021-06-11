Class {
	#name : #BaselineOfPharoEDA,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoEDA
}

{ #category : #baselines }
BaselineOfPharoEDA >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self includePharoEDAApi: spec.
			self includePharoEDAAdapters: spec.
			self includePharoEDACommon: spec.
			self includePharoEDAPorts: spec.
			self includePharoEDASettings: spec.
			self includePharoEDATools: spec.
			self declareBabyMock2In: spec.
			self declarePackagesIn: spec.
			self declareGroupsIn: spec ]
]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareBabyMock2In: spec [
	spec
		project: 'BabyMock2'
		with: [ spec
				className: #ConfigurationOfBabyMock2;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ].
	^ spec
]

{ #category : #meta }
BaselineOfPharoEDA >> declareGroupsIn: spec [
	spec
		group: 'core'
			with: #(#'EDA-Application' #'EDA-Commands' #'EDA-Events' #'EDA-Domain-GT-Extensions');
		group: 'tests'
			with: #(#'EDA-Commands-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Application-Tests' #'EDA-Domain-Tests' #'EDA-Projections-Tests');
		group: 'default' with: #('core' 'tests')
]

{ #category : #meta }
BaselineOfPharoEDA >> declarePackagesIn: spec [
	spec
		package: #'EDA-Events'
			with: [ spec requires: #('PharoEDACommon' 'PharoEDAApi' 'PharoEDAPorts') ];
		package: #'EDA-Commands'
			with: [ spec requires: #('PharoEDACommon' 'PharoEDAApi') ];
		package: #'EDA-Projections-Tests'
			with: [ spec requires: #('PharoEDACommon') ];
		package: #'EDA-TestSupport'
			with: [ spec requires: #('PharoEDAPorts') ];
		package: #'EDA-Application'
			with: [ spec
				requires:
					#('EDA-Events' 'EDA-Commands' 'PharoEDACommon' 'PharoEDASettings' 'PharoEDAAdapters') ];
		package: #'EDA-Commands-Tests'
			with: [ spec requires: #('BabyMock2' 'PharoEDACommon' 'EDA-TestSupport') ];
		package: #'EDA-Commands-Tests-Tests'
			with: [ spec requires: #('EDA-Commands-Tests') ];
		package: #'EDA-Application-Tests'
			with: [ spec requires: #('BabyMock2' 'PharoEDACommon' 'EDA-TestSupport') ];
		package: #'EDA-Domain-Tests'
			with: [ spec requires: #('BabyMock2' 'PharoEDACommon' 'EDA-TestSupport') ];
		package: #'EDA-Domain-GT-Extensions'
			with: [ spec requires: #('BabyMock2' 'PharoEDACommon') ]
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDAAdapters: spec [
	spec
		baseline: 'PharoEDAAdapters'
		with: [ spec repository: 'github://osoco/pharo-eda-adapters:main' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDAApi: spec [
spec
		baseline: 'PharoEDAApi'
		with: [ spec repository: 'github://osoco/pharo-eda-api:main' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDACommon: spec [
spec
		baseline: 'PharoEDACommon'
		with: [ spec repository: 'github://osoco/pharo-eda-common:main' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDAPorts: spec [
spec
		baseline: 'PharoEDAPorts'
		with: [ spec repository: 'github://osoco/pharo-eda-ports:main' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDASettings: spec [
spec
		baseline: 'PharoEDASettings'
		with: [ spec repository: 'github://osoco/pharo-eda-settings:main' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> includePharoEDATools: spec [
spec
		baseline: 'PharoEDATools'
		with: [ spec repository: 'github://osoco/pharo-eda-tools:main' ].
	^ spec
]
