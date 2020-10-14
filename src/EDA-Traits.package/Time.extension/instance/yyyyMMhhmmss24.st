*EDA-Traits
yyyyMMhhmmss24
	"Return a string of the form 1123 (for 11:23 am), 2154 (for 9:54 pm), of exactly 4 digits"

	^ String
		new: 12
		streamContents: [ :aStream | 
			self asYear start year
				printOn: aStream
				base: 10
				length: 4
				padded: true.
			self asMonth start month
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