helper
recursivelyFindRelativePathBetweenFile: aFileReference andFolder: aFolderReference
	((aFileReference isDirectory and: [ aFileReference = aFolderReference ])
		or: [ aFileReference parent = aFolderReference ])
		ifTrue: [ ^ OrderedCollection new ]
		ifFalse: [ | result |
			result := OrderedCollection with: aFileReference parent basename.
			result
				addAll: (self recursivelyFindRelativePathBetweenFile: aFileReference parent andFolder: aFolderReference).
			^ result ]