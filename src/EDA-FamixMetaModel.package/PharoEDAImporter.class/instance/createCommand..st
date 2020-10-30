public-entity-creation
createCommand: aCommandClassModel
	| command |
	command := commands
		at: aCommandClassModel
		put:
			(EDAFamixCommand new
				command: aCommandClassModel;
				parentPackage: aCommandClassModel parentPackage;
				yourself).
	^ command