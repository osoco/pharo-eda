helpers
checkTenantOfCommandIsValid: aCommand
	(self checkTenantIsValid: aCommand tenant)
		ifFalse:
			[ self logErrorMessage: 'tenant is missing' andThrow: InvalidTenant ]