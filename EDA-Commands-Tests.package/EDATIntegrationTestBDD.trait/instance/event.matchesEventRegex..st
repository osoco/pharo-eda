helper
event: eventMessage matchesEventRegex: eventMessageRegex
	^ self json: eventMessage matchesRegex: eventMessageRegex