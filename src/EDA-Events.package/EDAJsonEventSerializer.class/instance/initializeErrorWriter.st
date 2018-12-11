initialization
initializeErrorWriter
	self errorWriter: [ :error | self writeError: error ]