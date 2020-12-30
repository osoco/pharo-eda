baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self declareNeoJSONIn: spec.
			self declareBabyMock2In: spec.
			self declareMongotalkIn: spec.
			self declareVoyageIn: spec.
			self declareStampIn: spec.
			self declareDeployUtilsIn: spec.
			self declarePackagesIn: spec.
			self declareGroupsIn: spec
]
