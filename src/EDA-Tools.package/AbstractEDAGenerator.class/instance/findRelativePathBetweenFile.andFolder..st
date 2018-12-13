helper
findRelativePathBetweenFile: aFileReference andFolder: aFolderReference
	^ (self recursivelyFindRelativePathBetweenFile: aFileReference  andFolder: aFolderReference) reverse