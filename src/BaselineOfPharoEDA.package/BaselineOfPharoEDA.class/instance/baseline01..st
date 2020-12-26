baselines
baseline01: spec
	<baseline>
	spec
		for: #common
		do: [ self declareProjects: spec.
			self declarePackagesIn: spec.
			self declareGroups: spec ]