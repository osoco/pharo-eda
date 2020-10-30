public-entity-creation
createFromEventClass: aEventSourcingEventClassModel
	^ self new
		event: aEventSourcingEventClassModel;
		parentPackage: aEventSourcingEventClassModel parentPackage;
		yourself