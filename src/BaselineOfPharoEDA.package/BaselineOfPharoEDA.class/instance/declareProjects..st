baselines
declareProjects: spec
	self declareNeoJSONIn: spec.
	self declareBabyMock2In: spec.
	self declareVoyageMongoIn: spec.
	self declareStampIn: spec.
	self declareDeployUtilsIn: spec.
	self declareRoassal2In: spec.
	self declareGToolkitIn: spec.
	^ spec