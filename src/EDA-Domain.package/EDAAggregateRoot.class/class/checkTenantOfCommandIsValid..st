helpers
checkTenantOfCommandIsValid: aCommand
	(self checkTenantIsValid: aCommand tenant) ifFalse: [ self logErrorMessage: (String streamContents: [ :s | s nextPutAll: aCommand class greaseString; nextPutAll: ' rejected: tenant is invalid' ]) andThrow: InvalidTenant ]