helper
convertDictonaryToConditionalBlock: aDictionary
	| aBlock |
	aBlock := [ :each | 
	aDictionary associations
		allSatisfy: [ :association | (each perform: association key asSymbol) = association value ] ].
	^ aBlock