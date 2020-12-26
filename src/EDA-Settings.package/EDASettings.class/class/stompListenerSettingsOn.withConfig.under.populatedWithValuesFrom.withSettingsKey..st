settings
stompListenerSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry withSettingsKey: aKey
	| stompConfig ack timeout |
	stompConfig := (self retrieveSettingAsDict: configEntry under: aKey) ifNil: [ Dictionary new ].
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'STOMP host' translated;
		description: 'STOMP server host address';
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
	(aBuilder setting: #queue)
		parent: parent;
		target: container;
		label: 'Queue name' translated;
		description: 'Queue name' translated;
		default: (stompConfig at: 'queue' ifAbsent: 'unset').
	(aBuilder setting: #durable)
		parent: parent;
		target: container;
		label: 'Durable subscription' translated;
		description: 'Durability of subscription' translated;
		default: (stompConfig at: 'durable' ifAbsent: false).
	(stompConfig at: 'ack') asSymbol = #auto
		ifTrue:
			[ self logErrorMessage: 'ACK is AUTO. Using client-individual anyway' ].
	ack := #'client-individual'.
	(aBuilder pickOne: #ack)
		parent: parent;
		target: container;
		label: 'Ack policy' translated;
		description: 'Acknowledgement policy';
		domainValues:
			(OrderedCollection
				with: 'Auto' translated -> #auto
				with: 'Client' translated -> #client
				with: 'Client Individual' translated -> #'client-individual');
		default: ack.
	(aBuilder setting: #prefetchCount)
		parent: parent;
		target: container;
		label: 'Prefetch count' translated;
		description: 'Prefetch count' translated;
		default: (stompConfig at: 'prefetchCount' ifAbsent: 0).
	timeout := stompConfig at: 'timeout' ifAbsent: 1.
	(aBuilder setting: #timeout)
		parent: parent;
		target: container;
		label: 'Timeout' translated;
		description: 'Timeout (in seconds)' translated;
		default: timeout.
	(aBuilder setting: #commandListenerClientDebug)
		parent: parent;
		target: EDAApplication;
		label: 'STOMP client in debug mode' translated;
		description: 'Whether enable debug mode in the STOMP client' translated;
		default: (stompConfig at: 'debug' ifAbsent: false).
	(aBuilder setting: #restartOnCommandConsumingErrors)
		parent: parent;
		target: EDACommandConsumer;
		label: 'Restart on error' translated;
		description: 'Whether to restart the client in case of errros';
		default: (stompConfig at: 'restartOnError')
