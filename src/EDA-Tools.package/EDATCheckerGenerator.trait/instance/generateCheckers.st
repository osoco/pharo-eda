api
generateCheckers
	self
		compile: self checkerMethodName
		sourceCode: self checkerMethod
		inClass:
			(self class environment at: #ATSContractChecker)
		classifiedAs: self protocol