api
deleteQueue: aQueue inVirtualHost: vHost
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