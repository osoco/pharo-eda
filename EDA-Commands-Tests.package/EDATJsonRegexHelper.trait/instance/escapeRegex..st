regex logic
escapeRegex: aRegex
	| result |
	result := aRegex copyWithRegex: '<ANYTHING>' matchesReplacedWith: '(.*)'.
	result := result copyWithRegex: '1970-01-01T00\:00\:00' matchesReplacedWith: '(.*)'.
	result := result copyWithRegex: '\:' matchesReplacedWith: '\:'.
	^ result