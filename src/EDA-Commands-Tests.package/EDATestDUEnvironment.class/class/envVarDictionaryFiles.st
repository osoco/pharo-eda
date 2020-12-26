private
envVarDictionaryFiles
	^ OrderedCollection with: (
			FileLocator imageDirectory 
			/ 'config' 
			/ 'integration-tests.json'
		)