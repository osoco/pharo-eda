helper
removeSuffix: suffix fromFileName: aFile
	^ aFile basename copyWithRegex: (suffix copyWithRegex: '\.' matchesReplacedWith: '\.') , '$' matchesReplacedWith: ''