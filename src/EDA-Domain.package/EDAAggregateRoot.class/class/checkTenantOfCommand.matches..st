helpers
checkTenantOfCommand: tenantOfCommand matches: tenantOfAggregate
	tenantOfCommand isNil
		ifTrue: [ InvalidTenant signal ].
	(tenantOfAggregate isNotNil and: [ tenantOfCommand = tenantOfAggregate ])
		ifFalse: [ InvalidTenant signal ]