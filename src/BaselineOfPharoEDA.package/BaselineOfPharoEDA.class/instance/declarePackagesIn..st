meta
declarePackagesIn: spec
	spec
		package: #'EDA-Traits';
		package: #'EDA-Traits-Tests'
			with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Tools' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Tools-Tests' with: [ spec requires: #('EDA-Tools') ];
		package: #'EDA-Domain' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Domain-Tests'
			with: [ spec requires: #('EDA-Domain' 'ObjectDiff') ];
		package: #'EDA-Domain-GT-Extensions'
			with: [  spec requires: #(EDA-Domain) ];
		package: #'EDA-Commands-Tests-Tests'
			with: [ spec requires: #('EDA-Commands-Tests') ];
		package: #'EDA-EventStore' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Messaging' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Errors' with: [ spec requires: #('EDA-Traits' 'EDA-Messaging') ];
		package: #'EDA-SMTP' with: [ spec requires: #('EDA-Traits') ];
		package: #'EDA-Events'
			with: [ spec requires: #('EDA-Messaging' 'EDA-Traits') ];
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
			with: [ spec requires: #('Stamp' 'EDA-Traits') ];
		package: #'EDA-Voyage-EventStore'
			with: [ spec requires: #('Voyage') ];
		package: #'EDA-Application'
			with: [ spec
				requires:
					#('EDA-Events' 'EDA-Domain' 'EDA-Commands' 'EDA-Voyage-EventStore' 'EDA-Projections' 'EDA-StompMessaging') ];
		package: #'EDA-Settings'
			with: [ spec requires: #('DeployUtils' 'EDA-Traits' 'EDA-Application') ];
		package: #'EDA-Commands-Tests'
			with: [ spec
				requires: #('BabyMock2' 'EDA-Settings' 'EDA-StompMessaging' 'EDA-Domain-Tests') ]
