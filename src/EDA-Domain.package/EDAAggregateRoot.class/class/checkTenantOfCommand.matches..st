helpers
checkTenantOfCommand: tenantOfCommand matches: tenantOfAggregate
	tenantOfCommand ifNil: [ InvalidTenant signal ].
	(tenantOfAggregate isNotNil
		and: [ tenantOfCommand ~= tenantOfAggregate ])
		ifTrue: [ InvalidTenant signal ]