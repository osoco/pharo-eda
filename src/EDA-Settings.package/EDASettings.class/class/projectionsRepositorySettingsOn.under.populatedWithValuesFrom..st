settings
projectionsRepositorySettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry
	| symbol |
	symbol := (parent greaseString , 'ProjectionsRepository') asSymbol.
	(aBuilder group: symbol)
		label: 'Projections Repository' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: EDAProjectionMongoRepository
		under: symbol
		populatedWithValuesFrom: aConfigEntry