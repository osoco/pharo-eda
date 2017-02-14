private
envVarDictionaryFiles
	^ super envVarDictionaryFiles
		union: {
			FileLocator imageDirectory
			/ 'config'
			/ 'integration-tests.json'
		} asOrderedCollection