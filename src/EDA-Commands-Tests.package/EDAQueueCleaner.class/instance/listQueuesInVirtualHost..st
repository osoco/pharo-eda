api
listQueuesInVirtualHost: vHost
	| result client response |
	result := OrderedCollection new.
	(client := ZnClient new)
		http;
		host: self class host;
		port: self class port;
		username: self class username password: self class password;
		addPath: 'api';
		addPath: 'queues'.
	vHost ifNotNil: [ :v | client addPath: vHost ].
	client get.
	(client response code = 200) ifTrue: [
	response := NeoJSONReader fromString: client contents.
	response
		inject: result
		into: [ :aux :next | 
			aux addAll: ((next keys select: [ :k | k = 'name' ]) collect: [ :k | next at: k ]) asOrderedCollection flattened.
			aux ].
	result := result flattened.
	].
	^ result