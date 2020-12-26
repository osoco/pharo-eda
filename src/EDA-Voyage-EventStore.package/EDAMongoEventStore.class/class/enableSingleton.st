accessing
enableSingleton
	enableSingleton ifNil: [ self enableSingleton: true ].
	^ enableSingleton