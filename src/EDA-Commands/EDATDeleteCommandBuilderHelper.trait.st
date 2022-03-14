Trait {
	#name : #EDATDeleteCommandBuilderHelper,
	#category : #'EDA-Commands-Builders'
}

{ #category : #'instance creation' }
EDATDeleteCommandBuilderHelper >> buildFromJsonDict: commandParams [
	"Builds a command from given parameters"

	| commandMeta commandBody cmdCommandId cmdAttributes cmdContractVersion cmdVersion result cmdTenant |
	commandMeta := commandParams at: #meta.
	commandBody := commandParams at: #body.
		cmdTenant := commandBody at: 'tenant' ifAbsent: [ 'tenant' ].
	cmdCommandId := commandMeta
		at: 'id'
		ifPresent: [ :v | v ]
		ifAbsent: [ UUID new greaseString ].
	cmdAttributes := Dictionary empty.
	cmdContractVersion := commandMeta at: 'version' ifAbsent: [ 1 ].
	cmdAttributes at: 'version' put: cmdContractVersion.
	cmdVersion := commandBody at: 'version' ifAbsent: [ 0 ].
	commandBody
		at: 'id'
		ifPresent: [ :v | cmdAttributes at: 'id' put: v ].
	commandBody
		at: 'agent'
		ifPresent: [ :v | cmdAttributes at: 'agent' put: v ].
	cmdAttributes
		at: 'aggregateRootClass'
		put: (self retrieveAggregateRootClass: commandParams).
	result := EDADeleteAggregateCommand
		ofTenant: cmdTenant withCommandId: cmdCommandId
		aggregateRootVersion: cmdVersion
		andAttributes: cmdAttributes.
	^ result
]
