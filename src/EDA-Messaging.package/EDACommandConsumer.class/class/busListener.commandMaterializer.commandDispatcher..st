instance creation
busListener: busListener commandMaterializer: commandMaterializer commandDispatcher: commandDispatcher

	^ self new
		busListener: busListener;
		commandMaterializer: commandMaterializer;
		commandDispatcher: commandDispatcher;
		yourself