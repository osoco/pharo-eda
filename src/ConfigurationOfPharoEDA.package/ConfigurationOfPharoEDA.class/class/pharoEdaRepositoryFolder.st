loading
pharoEdaRepositoryFolder
	| baseFolder basePath exists folder |
	baseFolder := FileSystem workingDirectory.
	basePath := baseFolder fullPath.
	exists := (baseFolder fullPath / 'pharo-eda-common') asFileReference exists.
	folder := exists
		ifTrue: [ basePath / 'pharo-eda-common' ]
		ifFalse: [ baseFolder path segments last = 'bbva-ats'
				ifTrue: [ basePath / 'pharo-eda-common' ]
				ifFalse: [ basePath / 'bbva-ats' / 'pharo-eda-common' ] ].
	^ folder