Extension { #name : #ZnUrl }

{ #category : #'*EDA-Traits' }
ZnUrl >> decodePercent: arg1 [
	^ ZnResourceMetaUtils decodePercent: arg1 urlEncoded
]
