Extension { #name : #ZnUrl }

{ #category : #'*EDA-Traits' }
ZnUrl >> decodePercent: string [
	^ ZnResourceMetaUtils decodePercent: (self toAscii: string)
]

{ #category : #'*EDA-Traits' }
ZnUrl >> toAscii: aString [
	| replacements result |
	replacements := Dictionary new.
	replacements
		at: 'á' put: 'a';
		at: 'à' put: 'a';
		at: 'é' put: 'e';
		at: 'è' put: 'e';
		at: 'í' put: 'i';
		at: 'ì' put: 'i';
		at: 'ó' put: 'o';
		at: 'ò' put: 'o';
		at: 'ú' put: 'u';
		at: 'ù' put: 'u';
		at: 'ü' put: 'u';
		at: 'ñ' put: 'n';
		at: 'Á' put: 'A';
		at: 'À' put: 'A';
		at: 'É' put: 'E';
		at: 'È' put: 'E';
		at: 'Í' put: 'I';
		at: 'Ì' put: 'I';
		at: 'Ó' put: 'O';
		at: 'Ò' put: 'O';
		at: 'Ú' put: 'U';
		at: 'Ù' put: 'U';
		at: 'Ü' put: 'U';
		at: 'Ñ' put: 'N';
		at: '¡' put: '!';
		at: '¿' put: '?'.
	result := aString.
	replacements associations
		do: [ :assoc | 
			result := result
				keysAndValuesDo: [ :i :c | 
					assoc key first = c
						ifTrue: [ result at: i put: assoc value first ]
						ifFalse: [ result at: i put: c ] ] ].
	^ result
]
