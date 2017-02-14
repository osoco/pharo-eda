private
envVarDictionaryFiles
	^ { FileLocator imageDirectory
		/ 'config'
		/ (self currentEnvironment , '.json').
		"This leads to key conflicts. It was an initial attempt to support
		running more than one application in the same image.
		If that approach is resumed, this could be used as a reminder
		of the initial steps. Meanwhile it skips reading config
		files from other images since the keys in the json files
		are not unique.
		FileLocator imageDirectory parent
		/ 'game-core'
		/ 'config'
		/ (self currentEnvironment , '.json').
		FileLocator imageDirectory parent
		/ 'game-image-processor'
		/ 'config'
		/ (self currentEnvironment , '.json')."
		} asOrderedCollection.