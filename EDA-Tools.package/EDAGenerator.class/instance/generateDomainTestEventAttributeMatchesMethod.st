code generation
generateDomainTestEventAttributeMatchesMethod
	| result |
	result := 'attribute: myAttr matches: otherAttr', String cr.
	result := result , '^ myAttr = otherAttr or: [ myAttr = ' , $' asString , '<ANYTHING>', $' asString , ' ]' , String cr.
	^ result