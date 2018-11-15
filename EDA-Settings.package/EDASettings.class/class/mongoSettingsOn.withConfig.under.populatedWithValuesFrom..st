settings
mongoSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: mongoConfig
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'Mongo DB host' translated;
		description: 'Mongo DB host address' translated;
		order: 1;
		default: (mongoConfig at: 'host').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'Mongo DB port' translated;
		description: 'Mongo DB port' translated;
		default: (mongoConfig at: 'port').
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'Mongo username' translated;
		description: 'Mongo username' translated;
		default: (mongoConfig at: 'username').	
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'Mongo password' translated;
		description: 'Mongo password' translated;
		default: (mongoConfig at: 'password').	
	(aBuilder setting: #databaseName)
		parent: parent;
		target: container;
		label: 'Mongo database' translated;
		description: 'Mongo database name' translated;
		default: (mongoConfig at: 'database').								