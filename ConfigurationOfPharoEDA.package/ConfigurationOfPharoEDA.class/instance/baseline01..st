baselines
baseline01: spec
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'gitfiletree://' , FileSystem workingDirectory parent fullName , '/pharo-eda-common'.
		spec
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ];
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'stable';
					repository: 'github://pharo-nosql/voyage/mc' ];
			project: 'Stamp' with: [
				spec
					className: #ConfigurationOfStamp;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Stamp/main/' ].
		spec baseline: 'DeployUtils' with: [ spec repository: 'github://fstephany/DeployUtils/repository' ].
		spec
			package: #'EDA-Traits';
			package: #'EDA-Domain' with: [ spec requires: #('EDA-Traits') ];
			package: #'EDA-Domain-Tests' with: [ spec requires: #('EDA-Domain') ];
			package: #'EDA-EventStore' with: [ spec requires: #('EDA-Traits') ];
			package: #'EDA-Messaging' with: [ spec requires: #('EDA-Traits') ];
			package: #'EDA-Events' with: [ spec requires: #('EDA-Messaging' 'EDA-Traits') ];
			package: #'EDA-Commands' with: [
				spec requires: #('NeoJSON' 'EDA-Messaging' 'EDA-Traits') ];
			package: #'EDA-Projections';
			package: #'EDA-Projections-Tests' with: [
				spec requires: #('EDA-Traits') ];
			package: #'EDA-Projections-Voyage-Repository' with: [
				spec requires: #('EDA-Traits') ];
			package: #'EDA-StompMessaging' with: [
				spec requires: #('Stamp' 'EDA-Traits') ];
			package: #'EDA-Voyage-EventStore' with: [
				spec requires: #('VoyageMongo' ) ];
			package: #'EDA-Settings' with: [
				spec requires: #('DeployUtils') ];
			package: #'EDA-Commands-Tests' with: [
				spec requires: #('BabyMock2' 'EDA-Settings' 'EDA-StompMessaging' 'EDA-Domain-Tests' ) ];
			package: #'EDA-Application' with: [
				spec requires: #('EDA-Settings')].
		spec
			group: 'core' with: #(#'EDA-Application' #'EDA-Traits' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' );
			group: 'tests' with: #(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' );
			group: 'default' with: #('core' 'tests' ). ].
