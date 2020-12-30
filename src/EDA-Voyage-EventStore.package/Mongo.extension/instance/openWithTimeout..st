*EDA-Voyage-EventStore
openWithTimeout: aDuration
	| addr |
	"Waits the specified number of seconds to open the connection."
	addr := NetNameResolver addressForName: host timeout: 20.
	stream := ZdcSecureSocketStream openConnectionToHost: addr port: port timeout: aDuration asSeconds.
	stream sslSession serverName: self host.
	stream connect.
	stream socket setOption: 'TCP_NODELAY' value: 1.
	stream binary.
	authCache := nil