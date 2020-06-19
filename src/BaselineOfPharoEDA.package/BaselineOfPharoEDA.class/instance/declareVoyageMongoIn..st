dependencies
declareVoyageMongoIn: spec
	spec
		project: 'VoyageMongo'
		with: [ spec
				className: #ConfigurationOfVoyageMongo;
				versionString: #development;
				repository: 'github://pharo-nosql/voyage:1.6/mc';
				loads: #('core' 'memory') ].
	^ spec