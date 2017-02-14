settings
projectionsRepositorySettingsOn: aBuilder under: parent
	(aBuilder group: #projectionsRepository)
		label: 'Projections Repository' translated;
		parent: parent.

	^ self mongoSettingsOn: aBuilder withConfig: EDAProjectionMongoRepository under: #projectionsRepository populatedWithValuesFrom: 'projectionsRepository'
