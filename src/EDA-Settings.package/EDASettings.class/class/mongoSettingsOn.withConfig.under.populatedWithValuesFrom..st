settings
mongoSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: mongoConfig
	(aBuilder setting: #urls)
		parent: parent;
		target: container;
		label: 'Urls' translated;
		description: 'Comma-separated MongoDB urls';
		order: 1;
		default: (mongoConfig at: 'urls').
	(aBuilder setting: #tls)
		parent: parent;
		target: container;
		label: 'Use TLS' translated;
		description: 'Whether to connect using TLS';
		default: (mongoConfig at: 'tls').
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'Mongo username' translated;
		description: 'Mongo username';
		default: (mongoConfig at: 'username').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'Mongo password' translated;
		description: 'Mongo password';
		default: (mongoConfig at: 'password').
	(aBuilder setting: #databaseName)
		parent: parent;
		target: container;
		label: 'Mongo database' translated;
		description: 'Mongo database name';
		default: (mongoConfig at: 'database').
	(aBuilder pickOne: #authenticationMechanism)
		parent: parent;
		target: container;
		label: 'AuthenticationMechanism' translated;
		description: 'AuthenticationMechanism';
		domainValues:
			((MongoAuthMechanism allSubclasses reject: [ :item | item isAbstract ])
				collect: [ :item | item textDescription -> item ]);
		default:
			(MongoAuthMechanism allSubclasses
				select: [ :item |
					item isAbstract not
						and: [ item textDescription = (mongoConfig at: 'authenticationMechanism') ] ])
				first.
	(aBuilder setting: #debug)
		parent: parent;
		target: container;
		label: 'Debug' translated;
		description: 'Debug';
		default: (mongoConfig at: 'debug').
	(aBuilder setting: #enableReplication)
		parent: parent;
		target: container;
		label: 'Enable replication' translated;
		description: 'Enable replication';
		default: (mongoConfig at: 'enableReplication').
	(aBuilder setting: #enableSingleton)
		parent: parent;
		target: container;
		label: 'Enable singleton' translated;
		description: 'Enable singleton';
		default: (mongoConfig at: 'enableSingleton').
	(aBuilder setting: #ensuringCurrentOnSave)
		parent: parent;
		target: container;
		label: 'Current on save' translated;
		description: 'Ensure current on save';
		default: (mongoConfig at: 'ensuringCurrentOnSave').
	(aBuilder setting: #ensuringCurrentReferencesOnQueries)
		parent: parent;
		target: container;
		label: 'Current references on queries' translated;
		description: 'Ensure current references on queries';
		default: (mongoConfig at: 'ensuringCurrentReferencesOnQueries').
	(aBuilder setting: #lazySynchronize)
		parent: parent;
		target: container;
		label: 'Lazy synchronize';
		description: 'Lazy synchronize';
		default: (mongoConfig at: 'lazySynchronize').
	(aBuilder setting: #wireProtocolEnabled)
		parent: parent;
		target: container;
		label: 'Wire protocol' translated;
		description: 'Whether to enable wire protocol';
		default: (mongoConfig at: 'wireProtocolEnabled')