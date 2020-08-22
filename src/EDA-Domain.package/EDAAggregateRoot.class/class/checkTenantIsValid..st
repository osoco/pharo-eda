helpers
checkTenantIsValid: tenantOfCommand
	tenantOfCommand isNil
		ifTrue: [ InvalidTenant signal ]