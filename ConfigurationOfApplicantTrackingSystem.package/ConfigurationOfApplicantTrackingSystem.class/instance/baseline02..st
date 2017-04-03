as yet unclassified
baseline02: spec
	<version: '0.2-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'gitfiletree://' , FileSystem workingDirectory fullName.
			spec
				project: 'Pharo-EDA-Common'
				with: [ spec
						className: 'ConfigurationOfPharoEDA';
						repository: 'gitfiletree://' , FileSystem workingDirectory fullName , '/pharo-eda-common';
						versionString: #bleedingEdge ].
			spec
				project: 'Mustache'
				with: [ spec
						className: #ConfigurationOfMustache;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/NorbertHartl/Mustache/main' ].
			spec
				project: 'Zinc-Zodiac'
				with: [ spec
						className: #ConfigurationOfZincHTTPComponents;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main' ].
			spec
				package: 'ATS-Traits';
				package: 'ATS-Tools';
				package: 'ATS-Tools-Tests' with: [ spec requires: #('ATS-Tools') ];
				package: 'ATS-Notification' with: [ spec requires: #('Zinc-Zodiac' 'Mustache') ];
				package: 'ATS-Settings'  with: [ spec requires: #('ATS-Notification' 'Pharo-EDA-Common') ];
				package: 'ATS-Domain' with: [ spec requires: #('ATS-Traits') ];
				package: 'ATS-Domain-Tests' with: [ spec requires: #('ATS-Domain' 'Pharo-EDA-Common') ];
				package: 'ATS-Application' with: [ spec requires: #('ATS-Domain' 'ATS-Notification') ];
				package: 'ATS-Application-Tests' with: [ spec requires: #('ATS-Domain' 'ATS-Application') ].
			spec
				group: 'core' with: #('ATS-Domain' 'ATS-Application' 'ATS-Traits' 'ATS-Tools' 'ATS-Notification' 'ATS-Settings');
				group: 'tests' with: #('ATS-Domain-Tests' 'ATS-Application-Tests' 'ATS-Tools-Tests');
				group: 'default' with: #('core' 'tests') ]