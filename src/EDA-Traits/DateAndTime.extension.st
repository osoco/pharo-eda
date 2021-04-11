Extension { #name : #DateAndTime }

{ #category : #'*EDA-Traits' }
DateAndTime >> asYYYYmmddHMS [
	^ String
		streamContents: [ :s | 
			ExtendedDatePrinter new
				printDate: self
				format: #(3 2 1 $- 1 1 2)
				on: s.
			s nextPut: $-.
			self printHMSOn: s separatedBy: $- ]
]

{ #category : #'*EDA-Traits' }
DateAndTime >> jsonWriteOn: aStream [
	aStream nextPut: $'.
	self printOn: aStream.
	aStream nextPut: $'
]
