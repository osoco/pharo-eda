handling
writeFuelContext: aContext named: aString withBasename: aBasename
	| parentFolder |
	parentFolder := self class errorFolderFor: aBasename.
	^ EDAFuelHelper new
		writeFuelContext: aContext
		named: 'session.fuel'
		inFolder: parentFolder