helper
assertEvent: eventMessage matchesEventRegex: eventMessageRegex
	^ self assertJson: eventMessage matchesRegex: eventMessageRegex