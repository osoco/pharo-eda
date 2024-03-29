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
			self declareNeoJSONIn: spec.
			self declareBabyMock2In: spec.
			self declareVoyageIn: spec.
			self declareStampIn: spec.
			self declareDeployUtilsIn: spec.
			self declareObjectDiffIn: spec.
			self declareDiscordStIn: spec.
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

{ #category : #dependencies }
BaselineOfPharoEDA >> declareDiscordStIn: spec [
	spec baseline: 'DiscordSt' with: [ spec repository: 'github://osoco/DiscordSt/src' ].
	^ spec

]

{ #category : #meta }
BaselineOfPharoEDA >> declareGroupsIn: spec [
	spec
		group: 'core'
			with:
			#(#'EDA-Application' #'EDA-Errors' #'EDA-Traits' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Entities' #'EDA-Serializers' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-SMTP' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging' #'EDA-Multimodule-Migration');
		group: 'tests'
			with:
			#(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests' #'EDA-Multimodule-Migration-Tests');
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
		package: #'EDA-Traits'
			with: [  spec requires: #('DiscordSt') ];
		package: #'EDA-Traits-Tests'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Tools' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Tools-Tests' with: [ spec requires: #('EDA-Tools') ];
		package: #'EDA-Domain' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Domain-Tests'
			with: [ spec requires: #('EDA-Domain' 'EDA-Serializers' 'ObjectDiff') ];
		package: #'EDA-Commands-Tests-Tests'
			with: [ spec requires: #('EDA-Commands-Tests') ];
		package: #'EDA-EventStore' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Messaging' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-SMTP' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Events'
			with: [ spec requires: #('EDA-Messaging' 'EDA-Traits') ];
		package: #'EDA-Commands'
			with: [ spec requires: #('NeoJSON' 'EDA-Messaging' 'EDA-Traits') ];
		package: #'EDA-Entities' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Serializers';
		package: #'EDA-Errors'
			with: [ spec requires: #('EDA-Traits' 'EDA-Messaging') ];
		package: #'EDA-Logging';
		package: #'EDA-Projections'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Projections-Tests'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Projections-Voyage-Repository'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-StompMessaging'
			with: [ spec requires: #('Stamp' 'EDA-Traits') ];
		package: #'EDA-Voyage-EventStore'
			with: [ spec requires: #('Voyage') ];
		package: #'EDA-Multimodule-Migration';
		package: #'EDA-Multimodule-Migration-Tests' with: [ spec requires: #('EDA-Multimodule-Migration') ];
		package: #'EDA-Application'
			with: [ spec
				requires:
					#('EDA-Events' 'EDA-Domain' 'EDA-Commands' 'EDA-Voyage-EventStore' 'EDA-Projections' 'EDA-StompMessaging') ];
		package: #'EDA-Settings'
			with: [ spec requires: #('DeployUtils' 'EDA-Traits' 'EDA-Application') ];
		package: #'EDA-Commands-Tests'
			with: [ spec
				requires: #('BabyMock2' 'EDA-Settings' 'EDA-StompMessaging' 'EDA-Domain-Tests') ]
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
				repository:
					'github://pharo-nosql/voyage:' , self voyageReleaseForPharoVersion
						, '/mc' ].
	^ spec
]

{ #category : #dependencies }
BaselineOfPharoEDA >> voyageReleaseForPharoVersion [
	| release |
	SystemVersion current major = 8
		ifTrue: [ release := '1.7' ].
	SystemVersion current major = 9
		ifTrue: [ release := '1.7.1' ].
	^ release
]
