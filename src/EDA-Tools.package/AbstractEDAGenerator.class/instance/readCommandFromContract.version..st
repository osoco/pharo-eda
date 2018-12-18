helper
readCommandFromContract: contractName version: version
	^ self readFromContract: [ self retrieveCommandFile: contractName version: version ]