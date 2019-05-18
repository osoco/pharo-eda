baselines
declareProjects: spec
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
		baseline: 'Roassal2'
		with: [ spec repository: 'github://ObjectProfile/Roassal2:1df4118/src' ].
	spec
		baseline: 'GToolkit'
		with: [ spec repository: 'github://feenkcom/gtoolkit:v0.6.46/src' ].