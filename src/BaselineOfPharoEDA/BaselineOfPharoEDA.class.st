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
			self declareNeoJSONIn: spec.
			self declareBabyMock2In: spec.
			self declareDeployUtilsIn: spec.
			self declareObjectDiffIn: spec.
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

{ #category : #dependencies }
BaselineOfPharoEDA >> declareDeployUtilsIn: spec [
	spec baseline: 'DeployUtils' with: [ spec repository: 'github://fstephany/DeployUtils/repository' ].
	^ spec
]

{ #category : #meta }
BaselineOfPharoEDA >> declareGroupsIn: spec [
	spec
		group: 'core'
			with:
			#(#'EDA-Application' #'EDA-Commands' #'EDA-Events');
		group: 'tests'
			with:
			#(#'EDA-Commands-Tests' #'EDA-Commands-Tests-Tests');
		group: 'default' with: #('core' 'tests')
]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareMongotalkIn: spec [
	spec
		baseline: 'MongoTalk'
		with: [ spec
				repository: 'github://pharo-nosql/mongotalk:1.22/mc' ].
	^ spec

]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareNeoJSONIn: spec [
	spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareObjectDiffIn: spec [
	spec
		baseline: 'ObjectDiff'
		with: [ spec repository: 'github://rydnr/object-diff:main/src' ].
	^ spec
]

{ #category : #meta }
BaselineOfPharoEDA >> declarePackagesIn: spec [
	spec
		package: #'EDA-Events'
			with: [ spec
				requires: #('PharoEDACommon' 'PharoEDAApi' 'PharoEDAPorts') ];
		package: #'EDA-Commands'
			with: [ spec requires: #('NeoJSON' 'PharoEDACommon' 'PharoEDAApi') ];
		package: #'EDA-Projections-Tests'
			with: [ spec requires: #('PharoEDACommon') ];
		package: #'EDA-Application'
			with: [ spec
				requires:
					#('EDA-Events' 'EDA-Commands' 'PharoEDACommon' 'PharoEDASettings' 'PharoEDAAdapters') ];
		package: #'EDA-Commands-Tests'
			with: [ spec requires: #('BabyMock2' 'PharoEDACommon') ];
		package: #'EDA-Commands-Tests-Tests'
			with: [ spec requires: #('EDA-Commands-Tests') ]
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

{ #category : #dependencies }
BaselineOfPharoEDA >> includeStamp: spec [
	spec baseline: 'Stamp' with: [ spec repository: 'github://svenvc/stamp/repository' ].
	^ spec

]
