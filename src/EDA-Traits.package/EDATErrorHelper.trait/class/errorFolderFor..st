helpers
errorFolderFor: basename
	| parent result |
	parent := FileSystem workingDirectory / 'errors'.
	parent createDirectory.
	result := parent / basename greaseString.
	result createDirectory