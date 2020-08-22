helpers
checkTenantOfCommand: tenantOfCommand matches: tenantOfAggregate
	tenantOfCommand isNil
		ifTrue: [ InvalidTenant signal ].
	tenantOfCommand = tenantOfAggregate
		ifFalse: [ InvalidTenant signal ]