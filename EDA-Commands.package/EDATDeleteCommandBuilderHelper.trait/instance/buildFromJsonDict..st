instance creation
buildFromJsonDict: commandParams
	"Builds a command from given parameters"

	| commandMeta commandBody cmdCommandId cmdAttributes cmdContractVersion cmdVersion result |
	commandMeta := commandParams at: #meta.
	commandBody := commandParams at: #body.
	cmdCommandId := commandMeta at: 'id' ifPresent: [ :v | v ] ifAbsent: [ UUID new greaseString ].
	cmdAttributes := Dictionary new.
	cmdContractVersion := commandMeta at: 'version' ifAbsent: [ 1 ].
	cmdAttributes at: 'version' put: cmdContractVersion.
	cmdVersion := commandBody at: 'version' ifAbsent: [ 0 ].
	cmdAttributes at: 'aggregateRootVersion' put: cmdVersion.
	commandBody at: 'id' ifPresent: [ :v | cmdAttributes at: 'id' put: v ].
	cmdAttributes at: 'aggregateRootClass' put: (self retrieveAggregateRootClass: commandParams).
	result := EDADeleteAggregateCommand withCommandId: cmdCommandId aggregateRootVersion: cmdVersion andAttributes: cmdAttributes.
	commandBody at: 'id' ifPresent: [ :v | result aggregateRootId: v ].
	result version: cmdContractVersion.
	result aggregateRootVersion: cmdVersion.
	^ result