baselines
baseline01: spec
	<version: '0.1-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self declareProjects: spec.
			self declarePackages: spec.
			self declareGroups: spec ]