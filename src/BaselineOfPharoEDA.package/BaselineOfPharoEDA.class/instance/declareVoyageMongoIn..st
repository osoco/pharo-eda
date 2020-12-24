dependencies
declareVoyageMongoIn: spec
	spec
		project: 'VoyageMongo'
		with: [ spec
				className: #ConfigurationOfVoyageMongo;
				versionString: #development;
				repository: 'github://osoco/voyage:master/mc';
				loads: #('core' 'memory') ].
	^ spec
