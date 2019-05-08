accessing
descriptionBuilder
	^ descriptionBuilder
		ifNil: [ descriptionBuilder := EDAVODescriptionBuilder repository: self ]