Extension { #name : #Time }

{ #category : #'*EDA-Traits' }
Time >> hhmmss24 [
	"Return a string of the form 1123 (for 11:23 am), 2154 (for 9:54 pm), of exactly 4 digits"

	^ String
		new: 6
		streamContents: [ :aStream |
			self hour
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			self minute
				printOn: aStream
				base: 10
				length: 2
				padded: true.
							self second
				printOn: aStream
				base: 10
				length: 2
				padded: true ]
]

{ #category : #'*EDA-Traits' }
Time >> yyyyMMddhhmmss24 [
	| year month day |
	self asDateAndTime dayMonthYearDo: [ :d :m :y | year := y. month := m. day := d ].
	^ String
		new: 14
		streamContents: [ :aStream |
			year
				printOn: aStream
				base: 10
				length: 4
				padded: true.
			month
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			day
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			self hour
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			self minute
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			self second
				printOn: aStream
				base: 10
				length: 2
				padded: true ]
]
