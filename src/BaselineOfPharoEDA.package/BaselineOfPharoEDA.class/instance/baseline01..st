baselines
baseline01: spec
	<baseline>
	spec
		for: #common
		do: [
			self declareProjects: spec.
			self declarePackages: spec.
			self declareGroups: spec ]