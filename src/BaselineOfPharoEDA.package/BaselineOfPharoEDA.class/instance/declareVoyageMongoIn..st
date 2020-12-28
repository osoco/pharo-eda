dependencies
declareVoyageMongoIn: spec
	spec
		project: 'VoyageMongo'
		with: [ spec
				baseline: #Voyage;
				repository: 'github://osoco/voyage:1.7-tls/mc';
				loads: #('core' 'memory') ].
	^ spec
