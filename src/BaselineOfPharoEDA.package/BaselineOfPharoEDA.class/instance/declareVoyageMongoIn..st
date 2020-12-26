dependencies
declareVoyageMongoIn: spec
	spec
		project: 'VoyageMongo'
			with: [ spec
				className: #ConfigurationOfVoyageMongo;
				versionString: #development;
				repository: 'github://osoco/voyage:mastertls/mc';
				loads: #('core' 'memory') ].
	^ spec
