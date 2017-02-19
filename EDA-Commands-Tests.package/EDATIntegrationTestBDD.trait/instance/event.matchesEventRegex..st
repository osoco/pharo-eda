helper
event: eventMessage matchesEventRegex: eventMessageRegex
	| escapedEventMessageRegex |
	escapedEventMessageRegex := eventMessageRegex copyWithRegex: '<ANYTHING>' matchesReplacedWith: '(.*)'.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\:' matchesReplacedWith: '\:'.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\{' matchesReplacedWith: '\{'.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\}' matchesReplacedWith: '\}'.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\[' matchesReplacedWith: '\['.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\]' matchesReplacedWith: '\]'.
	escapedEventMessageRegex := escapedEventMessageRegex copyWithRegex: '\?' matchesReplacedWith: '\?'.
	^ (self condenseString: eventMessage) matchesRegex: (self condenseString: escapedEventMessageRegex)