helper
attribute: myAttr named: attrName matches: otherAttr
	^ myAttr = otherAttr
		or: [ (self class isEventGenerated: attrName)
				or: [ (self isAnything: myAttr)
						or: [ (self isAnyTimestamp: myAttr)
								or: [ (self bothAreCollections: myAttr andTheirContentsMatch: otherAttr) or: [ self bothAreDictionaries: myAttr andTheirContentsMatch: otherAttr ] ] ] ] ]