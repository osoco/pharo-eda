settings
projectionErrorHandlingSettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry
	(aBuilder group: #errors)
		label: 'Projection errors' translated;
		description: 'Projection error handling';
		noOrdering;
		parent: #projections.
	(aBuilder pickOne: #strategy)
		parent: #errors;
		target: EDAProjectionErrorBehavior;
		label: 'Default projection Error Handling' translated;
		description: 'Default trategy when dealing with errors projecting events';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect: [ :strategy | strategy description -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
	self
		customProjectionErrorBehaviorsOn: aBuilder
		under: #errors
		populatedWithValuesFrom: aConfigEntry