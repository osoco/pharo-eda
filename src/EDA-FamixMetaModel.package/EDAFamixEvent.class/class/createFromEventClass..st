public-entity-creation
createFromEventClass: aEventSourcingEventClassModel
	^ self new
		eventClassModel: aEventSourcingEventClassModel;
		parentPackage: aEventSourcingEventClassModel parentPackage;
		yourself