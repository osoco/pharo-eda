*EDA-Settings
initialize
	self currentEnvironment: (OSPlatform current environment at: self environmentVariableName ifAbsent: 'development')