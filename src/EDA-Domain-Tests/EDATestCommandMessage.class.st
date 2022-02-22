Class {
	#name : #EDATestCommandMessage,
	#superclass : #EDATestMessage,
	#category : #'EDA-Domain-Tests'
}

{ #category : #'instance creation' }
EDATestCommandMessage class >> checkValidClass: aCommandClass [.
	(aCommandClass == EDACommand or: [ aCommandClass inheritsFrom: EDACommand ]) ifFalse: [ self logErrorMessage: (aCommandClass name , ' is not a command class') andThrow: EDAInvalidClassToCreateTestMessage ].
]

{ #category : #helper }
EDATestCommandMessage class >> domainToMessageAttributesMap [
	^ EDADefaultCommandBuilder domainToMessageAttributesMap
]

{ #category : #'helper - inst var checking' }
EDATestCommandMessage >> instVarsNeededException [
	^ EDACommandInstVarsNeeded
]

{ #category : #'helper - inst var checking' }
EDATestCommandMessage >> instVarsNeededMessage [
	^ [ :instvars :className | 'Check creation of instance variables: ' , instvars 
						, ' and accessors for class ' , className , ' or add them to its attributesReceivedNotRequired' ]
]
