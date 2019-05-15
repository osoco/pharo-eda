settings
queueCleanerSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: config
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'RabbitMQ host' translated;
		description: 'RabbitMQ host address' translated;
		order: 1;
		default: (config at: 'host').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'RabbitMQ HTTP port' translated;
		description: 'RabbitMQ HTTP port' translated;
		default: (config at: 'httpPort').
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'RabbitMQ user' translated;
		description: 'RabbitMQ admin username' translated;
		default: (config at: 'user').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'RabbitMQ password' translated;
		description: 'RabbitMQ admin password' translated;
		default: (config at: 'password')