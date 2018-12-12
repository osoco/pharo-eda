baselines
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'github://osoco/pharo-eda:BATS-1725__Migration_to_Iceberg/src'.
			spec
				baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
				project: 'BabyMock2'
					with: [ spec
						className: #ConfigurationOfBabyMock2;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
				project: 'VoyageMongo'
					with: [ spec
						className: #ConfigurationOfVoyageMongo;
						versionString: #development;
						repository: 'github://pharo-nosql/voyage:1.5/mc';
						loads: #('core' 'memory') ];
				project: 'Stamp'
					with: [ spec
						className: #ConfigurationOfStamp;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Stamp/main/' ].
			spec baseline: 'DeployUtils' with: [ spec repository: 'github://fstephany/DeployUtils/repository' ].
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
				package: #'EDA-Events' with: [ spec requires: #('EDA-Messaging' 'EDA-Traits') ];
				package: #'EDA-Commands' with: [ spec requires: #('NeoJSON' 'EDA-Messaging' 'EDA-Traits') ];
				package: #'EDA-Logging';
				package: #'EDA-Projections';
				package: #'EDA-Projections-Tests' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-Projections-Voyage-Repository' with: [ spec requires: #('EDA-Traits') ];
				package: #'EDA-StompMessaging' with: [ spec requires: #('Stamp' 'EDA-Traits') ];
				package: #'EDA-Voyage-EventStore' with: [ spec requires: #('VoyageMongo') ];
				package: #'EDA-Application'
					with: [ spec requires: #('EDA-Events' 'EDA-Domain' 'EDA-Commands' 'EDA-Voyage-EventStore' 'EDA-Projections' 'EDA-StompMessaging') ];
				package: #'EDA-Settings' with: [ spec requires: #('DeployUtils' 'EDA-Traits' 'EDA-Application') ];
				package: #'EDA-Commands-Tests' with: [ spec requires: #('BabyMock2' 'EDA-Settings' 'EDA-StompMessaging' 'EDA-Domain-Tests') ].
			spec
				group: 'core'
					with:
					#(#'EDA-Application' #'EDA-Traits' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging');
				group: 'tests'
					with: #(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests');
				group: 'default' with: #('core' 'tests') ]