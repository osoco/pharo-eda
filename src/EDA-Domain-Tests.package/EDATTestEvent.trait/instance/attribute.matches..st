helper
attribute: myAttr matches: otherAttr
	^ myAttr = otherAttr
				or: [ (self isAnything: myAttr) or: [ self isAnyTimestamp: myAttr ] ]