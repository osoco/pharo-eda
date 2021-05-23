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
			self includePharoEDAApi: spec.
			self includePharoEDAPorts: spec.
			self includePharoEDASettings: spec.
			self includePharoEDATools: spec.
			self declareNeoJSONIn: spec.
			self declareBabyMock2In: spec.
			self declareVoyageIn: spec.
			"self declareMongotalkIn: spec."
			self declareStampIn: spec.
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
			#(#'EDA-Traits' #'EDA-Settings-Ports' #'EDA-Settings-Adapters-InMemory' #'EDA-Settings-Adapters-EnvVars' #'EDA-Settings-Adapters-ByPriority' #'EDA-Application' #'EDA-Errors' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-SMTP' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging');
		group: 'tests'
			with:
			#(#'EDA-Traits' #'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests');
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
		package: #'EDA-Traits';
		package: #'EDA-Traits-Tests'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Settings-Ports'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Settings-Adapters-InMemory'
			with: [ spec requires: #('EDA-Traits' 'EDA-Settings-Ports') ];
		package: #'EDA-Settings-Adapters-EnvVars'
			with: [ spec requires: #('EDA-Traits' 'EDA-Settings-Ports') ];
		package: #'EDA-Settings-Adapters-ByPriority'
			with: [ spec
				requires:
					#('EDA-Traits' 'EDA-Settings-Ports' 'EDA-Settings-Adapters-InMemory' 'EDA-Settings-Adapters-EnvVars') ];
		package: #'EDA-Tools' with: [ spec requires: #('EDA-Traits' 'PharoEDATools') ];
		package: #'EDA-Tools-Tests'
			with: [ spec requires: #('EDA-Tools' 'EDA-Traits') ];
		package: #'EDA-Domain' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Domain-Tests'
			with: [ spec requires: #('EDA-Domain' 'ObjectDiff') ];
		package: #'EDA-EventStore' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Messaging' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Errors'
			with: [ spec requires: #('EDA-Traits' 'EDA-Messaging') ];
		package: #'EDA-SMTP' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Events'
			with: [ spec requires: #('EDA-Messaging' 'EDA-Traits' 'PharoEDAApi' 'PharoEDAPorts') ];
		package: #'EDA-Commands'
			with: [ spec requires: #('NeoJSON' 'EDA-Messaging' 'EDA-Traits') ];
		package: #'EDA-Logging';
		package: #'EDA-Projections'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Projections-Tests'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Projections-Voyage-Repository'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-StompMessaging'
			with: [ spec requires: #('Stamp' 'EDA-Traits' 'PharoEDAAdapters') ];
		package: #'EDA-Voyage-EventStore'
			with: [ spec requires: #('Voyage' 'EDA-Traits') ];
		package: #'EDA-Application'
			with: [ spec
				requires:
					#('EDA-Settings-Ports' 'EDA-Events' 'EDA-Domain' 'EDA-Commands' 'EDA-Voyage-EventStore' 'EDA-Projections' 'EDA-StompMessaging' 'EDA-Traits') ];
		package: #'EDA-Settings'
			with: [ spec requires: #('DeployUtils' 'EDA-Traits' 'EDA-Application' 'PharoEDASettings') ];
		package: #'EDA-Commands-Tests'
			with: [ spec
				requires:
					#('BabyMock2' 'EDA-Settings' 'EDA-Traits' 'EDA-StompMessaging' 'EDA-Domain-Tests') ];
		package: #'EDA-Commands-Tests-Tests'
			with: [ spec requires: #('EDA-Commands-Tests') ]
]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareStampIn: spec [
	spec baseline: 'Stamp' with: [ spec repository: 'github://svenvc/stamp/repository' ].
	^ spec

]

{ #category : #dependencies }
BaselineOfPharoEDA >> declareVoyageIn: spec [
	spec
		baseline: 'Voyage'
		with: [ spec
				repository: 'github://pharo-nosql/voyage:1.7/mc' ].
	^ spec

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
