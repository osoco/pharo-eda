Class {
	#name : #EDATestDUEnvironment,
	#superclass : #EDADUEnvironment,
	#category : 'EDA-Commands-Tests'
}

{ #category : #private }
EDATestDUEnvironment class >> envVarDictionaryFiles [
	^ super envVarDictionaryFiles
		union: {
			FileLocator imageDirectory 
			/ 'config' 
			/ 'integration-tests.json'
		} asOrderedCollection
]
