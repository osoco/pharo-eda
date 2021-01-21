Class {
	#name : #EDAQueueCleaner,
	#superclass : #Object,
	#classInstVars : [
		'host',
		'port',
		'username',
		'password',
		'queues'
	],
	#category : 'EDA-Commands-Tests'
}

{ #category : #defaults }
EDAQueueCleaner class >> defaultVirtualHost [
	^ '/'
]

{ #category : #accessing }
EDAQueueCleaner class >> host [
	^ host
]

{ #category : #accessing }
EDAQueueCleaner class >> host: aString [
	host := aString
]

{ #category : #accessing }
EDAQueueCleaner class >> password [
	^ password
]

{ #category : #accessing }
EDAQueueCleaner class >> password: aString [
	password := aString
]

{ #category : #accessing }
EDAQueueCleaner class >> port [
	^ port
]

{ #category : #accessing }
EDAQueueCleaner class >> port: anInteger [
	port := anInteger
]

{ #category : #accessing }
EDAQueueCleaner class >> username [
	^ username
]

{ #category : #accessing }
EDAQueueCleaner class >> username: aString [
	username := aString
]

{ #category : #api }
EDAQueueCleaner >> deleteAllQueues [
	^ self deleteAllQueuesInVirtualHost: self class defaultVirtualHost
]

{ #category : #api }
EDAQueueCleaner >> deleteAllQueuesInVirtualHost: vHost [
	| queues result |
	queues := self listQueuesInVirtualHost: vHost.
	result := (queues anySatisfy: [ :q | (self deleteQueue: q inVirtualHost: vHost) not ]) not.
	^ result
]

{ #category : #api }
EDAQueueCleaner >> deleteQueue: aQueue [
	^ self deleteQueue: aQueue inVirtualHost: self class defaultVirtualHost

]

{ #category : #api }
EDAQueueCleaner >> deleteQueue: aQueue inVirtualHost: vHost [
	| client response |
	(client := ZnClient new)
		http;
		host: self class host;
		port: self class port;
		username: self class username password: self class password;
		url: '/api/queues/' , vHost urlEncoded , '/' , aQueue urlEncoded , '/contents';
		delete.
	response := client response code.
	^ response = 204
]

{ #category : #api }
EDAQueueCleaner >> listQueues [
	^ self listQueuesInVirtualHost: self class defaultVirtualHost
]

{ #category : #api }
EDAQueueCleaner >> listQueuesInVirtualHost: vHost [
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
]
