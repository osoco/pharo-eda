settings
stompPublisherSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry
	| stompConfig |
	stompConfig := self retrieveSettingAsDict: configEntry.
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'STOMP host' translated;
		description: 'STOMP server host address';
		order: 1;
		default: (stompConfig at: 'host').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'STOMP port' translated;
		description: 'STOMP server port';
		default: (stompConfig at: 'port').
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'STOMP username' translated;
		description: 'STOMP username';
		default: (stompConfig at: 'user').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'STOMP password' translated;
		description: 'STOMP password';
		default: (stompConfig at: 'password').
	(aBuilder setting: #exchange)
		parent: parent;
		target: container;
		label: 'Exchange name' translated;
		description: 'Exchange name';
		default: (stompConfig at: 'exchange').
	(aBuilder setting: #routingKey)
		parent: parent;
		target: container;
		label: 'Routing key';
		description: 'Routing key';
		default: (stompConfig at: 'routingKey').
	(aBuilder setting: #durable)
		parent: parent;
		target: container;
		label: 'Durable subscription' translated;
		description: 'Durability of subscription';
		default: (stompConfig at: 'durable').
	(aBuilder setting: #timeout)
		parent: parent;
		target: container;
		label: 'Timeout' translated;
		description: 'Timeout (in seconds)';
		default: (stompConfig at: 'timeout').
			(aBuilder setting: #errorExchange)
		parent: parent;
		target: container;
		label: 'Error exchange' translated;
		description: 'The exchange for errors';
		default: (stompConfig at: 'errorExchange')