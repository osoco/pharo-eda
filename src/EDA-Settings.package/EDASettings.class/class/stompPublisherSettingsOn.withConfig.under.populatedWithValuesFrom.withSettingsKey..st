settings
stompPublisherSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry withSettingsKey: aKey
	| stompConfig |
	stompConfig := (self retrieveSettingAsDict: configEntry under: aKey) ifNil: [ Dictionary new ].
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'STOMP host' translated;
		description: 'STOMP server host address' translated;
		order: 1;
		default: (stompConfig at: 'host' ifAbsent: 'unset').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'STOMP port' translated;
		description: 'STOMP server port' translated;
		default: (stompConfig at: 'port' ifAbsent: 0).
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'STOMP username' translated;
		description: 'STOMP username' translated;
		default: (stompConfig at: 'user' ifAbsent: 'unset').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'STOMP password' translated;
		description: 'STOMP password' translated;
		default: (stompConfig at: 'password' ifAbsent: 'unset').
	(aBuilder setting: #exchange)
		parent: parent;
		target: container;
		label: 'Exchange name' translated;
		description: 'Exchange name' translated;
		default: (stompConfig at: 'exchange' ifAbsent: 'unset').
	(aBuilder setting: #routingKey)
		parent: parent;
		target: container;
		label: 'Routing key' translated;
		description: 'Routing key' translated;
		default: (stompConfig at: 'routingKey' ifAbsent: 'unset').
	(aBuilder setting: #durable)
		parent: parent;
		target: container;
		label: 'Durable subscription' translated;
		description: 'Durability of subscription' translated;
		default: (stompConfig at: 'durable' ifAbsent: false).
	(aBuilder setting: #timeout)
		parent: parent;
		target: container;
		label: 'Timeout' translated;
		description: 'Timeout (in seconds)' translated;
		default: (stompConfig at: 'timeout' ifAbsent: 0)