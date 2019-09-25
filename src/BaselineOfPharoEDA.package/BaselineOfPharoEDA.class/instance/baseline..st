baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self declareNeoJSONIn: spec.
			self declareBabyMock2In: spec.
			self declareVoyageMongoIn: spec.
			self declareStampIn: spec.
			self declareDeployUtilsIn: spec.
			spec
				package: #'EDA-Traits';
				package: #'EDA-Traits-Tests' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Tools' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Tools-Tests' with: [ spec requires: #('EDA-Tools') ];
				package: #'EDA-Domain' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Domain-Tests' with: [ spec requires: #('EDA-Domain') ];
				package: #'EDA-Commands-Tests-Tests' with: [ spec requires: #('EDA-Commands-Tests') ];
				package: #'EDA-EventStore' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Messaging' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-SMTP' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Events' with: [ spec requires: #('EDA-Messaging' 'EDA-Traits') ];
				package: #'EDA-Commands' with: [ spec requires: #('NeoJSON' 'EDA-Messaging' 'EDA-Traits') ];
				package: #'EDA-Logging';
				package: #'EDA-Projections';
				package: #'EDA-Projections-Tests' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Projections-Voyage-Repository' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-StompMessaging' with: [ spec requires: #('Stamp' 'EDA-Traits') ];
				package: #'EDA-Voyage-EventStore' with: [ spec requires: #('VoyageMongo') ];
				package: #'EDA-Application'
					with: [ spec
						requires: #('EDA-Events' 'EDA-Domain' 'EDA-Commands' 'EDA-Voyage-EventStore' 'EDA-Projections' 'EDA-StompMessaging') ];
				package: #'EDA-Settings' with: [ spec requires: #('DeployUtils' 'EDA-Traits' 'EDA-Application') ];
				package: #'EDA-Commands-Tests'
					with: [ spec requires: #('BabyMock2' 'EDA-Settings' 'EDA-StompMessaging' 'EDA-Domain-Tests') ].
			spec
				group: 'core'
					with:
					#(#'EDA-Application' #'EDA-Traits' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-SMTP' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging');
				group: 'tests'
					with:
					#(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests');
				group: 'default' with: #('core' 'tests') ]
