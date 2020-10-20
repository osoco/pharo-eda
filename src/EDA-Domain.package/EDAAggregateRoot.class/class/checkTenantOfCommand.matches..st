helpers
checkTenantOfCommand: aCommand matches: anAggregate
	| result |
	result := (self checkTenantIsValid: aCommand tenant)
		ifTrue: [ aCommand tenant = anAggregate tenant ]
		ifFalse: [ false ].
	result
		ifFalse: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: aCommand class greaseString;
								nextPutAll: ' rejected: Invalid tenant (';
								nextPutAll: aCommand tenant;
								nextPutAll: '). Aggregate''s tenant: ';
								nextPutAll: anAggregate tenant greaseString])
				andThrow: InvalidTenant ]