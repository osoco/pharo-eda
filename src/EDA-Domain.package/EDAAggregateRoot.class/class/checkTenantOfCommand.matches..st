helpers
checkTenantOfCommand: aCommandTenant matches: anAggregateTenant
	| result |
	result := (self checkTenantIsValid: aCommandTenant)
		ifTrue: [ aCommandTenant = anAggregateTenant ]
		ifFalse: [ false ].
	result
		ifFalse: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Invalid tenant (';
								nextPutAll: aCommandTenant;
								nextPutAll: '), aggregate''s tenant: ';
								nextPutAll: anAggregateTenant greaseString ])
				andThrow: InvalidTenant ]