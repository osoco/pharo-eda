building
buildEmptyFromJsonDict: jsonDict
	| meta body |
	meta := jsonDict at: #meta.
	body := jsonDict at: #body.
	^ self buildCommandFromCommandName: (meta at: #type)