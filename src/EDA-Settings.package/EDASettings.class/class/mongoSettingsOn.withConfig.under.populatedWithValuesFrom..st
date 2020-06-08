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
	(aBuilder pickOne: #authenticationMechanism)
		parent: parent;
		target: container;
		label: 'AuthenticationMechanism' translated;
		description: 'AuthenticationMechanism' translated;
		domainValues:
			(MongoAuthMechanism allSubclasses
				select: [ :item | item isAbstract not ]
				thenCollect: [ :item | item description translated -> item ]);
		default:
			(MongoAuthMechanism allSubclasses
				select: [ :item |
					item isAbstract not
						and: [ item description = (mongoConfig at: 'authenticationMechanism') ] ]) first.
	(aBuilder setting: #debug)
		parent: parent;
		target: container;
		label: 'Debug' translated;
		description: 'Debug' translated;
		default: (mongoConfig at: 'debug').
	(aBuilder setting: #enableReplication)
		parent: parent;
		target: container;
		label: 'Enable replication' translated;
		description: 'Enable replication' translated;
		default: (mongoConfig at: 'enableReplication').
	(aBuilder setting: #enableSingleton)
		parent: parent;
		target: container;
		label: 'Enable singleton' translated;
		description: 'Enable singleton' translated;
		default: (mongoConfig at: 'enableSingleton').
	(aBuilder setting: #ensuringCurrentOnSave)
		parent: parent;
		target: container;
		label: 'Current on save' translated;
		description: 'Ensure current on save' translated;
		default: (mongoConfig at: 'ensuringCurrentOnSave').
	(aBuilder setting: #ensuringCurrentReferencesOnQueries)
		parent: parent;
		target: container;
		label: 'Current references on queries' translated;
		description: 'Ensure current references on queries' translated;
		default: (mongoConfig at: 'ensuringCurrentReferencesOnQueries').
	(aBuilder setting: #forceEager)
		parent: parent;
		target: container;
		label: 'Force eager' translated;
		description: 'Force eager' translated;
		default: (mongoConfig at: 'forceEager').
	(aBuilder setting: #lazySynchronize)
		parent: parent;
		target: container;
		label: 'Lazy synchronize' translated;
		description: 'Lazy synchronize' translated;
		default: (mongoConfig at: 'lazySynchronize').
	(aBuilder setting: #wireProtocolEnabled)
		parent: parent;
		target: container;
		label: 'Wire protocol' translated;
		description: 'Whether to enable wire protocol' translated;
		default: (mongoConfig at: 'wireProtocolEnabled')