accessing
synchronizationInProgressOfTenant: aTenant
	^ synchronizationInProgressByTenant at: aTenant ifAbsent: [ false ]