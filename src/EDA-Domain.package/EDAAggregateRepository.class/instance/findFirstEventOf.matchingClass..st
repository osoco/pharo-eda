api
findFirstEventOf: aCollection matchingClass: aClass
	| result events |
	events := self findEventsOf: aCollection matchingClass: aClass.
	result := events ifEmpty: [ nil ] ifNotEmpty: [ :c | c first ].
	^ result