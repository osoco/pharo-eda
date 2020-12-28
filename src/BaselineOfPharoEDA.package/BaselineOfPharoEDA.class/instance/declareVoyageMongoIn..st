dependencies
declareVoyageMongoIn: spec
	spec
		project: 'VoyageMongo'
		with: [ spec
				className: #ConfigurationOfVoyageMongo;
				versionString: #development;
				repository: 'github://osoco/voyage:1.7-tls/mc';
				loads: #('core' 'memory') ].
	^ spec
