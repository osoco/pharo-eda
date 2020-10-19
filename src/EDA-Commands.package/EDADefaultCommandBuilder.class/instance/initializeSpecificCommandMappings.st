initialization
initializeSpecificCommandMappings
	" Add here specific mappings"

	commandDictionary
		at: #FORM_SUBMITTED put: ATSSubmitApplicationForm;
		at: #NEW_TOKEN_GENERATED put: ATSUpdateApplicationToken.
