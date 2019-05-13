accessing
enableReplication
	enableReplication ifNil: [ self enableReplication: false ].
	^ enableReplication 