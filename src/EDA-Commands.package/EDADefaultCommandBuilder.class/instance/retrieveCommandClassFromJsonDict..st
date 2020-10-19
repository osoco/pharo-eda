building
retrieveCommandClassFromJsonDict: jsonDict
	| meta body |
	meta := jsonDict at: #meta.
	body := jsonDict at: #body.
	^ self retrieveCommandClassFromCommandName: (meta at: #type)