Class {
	#name : #EDAStringTest,
	#superclass : #TestCase,
	#category : #'EDA-Traits-Tests'
}

{ #category : #tests }
EDAStringTest >> testAsURLWorkWithNonAscii [
	self
		shouldnt:
			[ 'https://s3-eu-west-1.amazonaws.com/mail-templates.core.contestia.nexplore.com/00005/Test challenge 4 María/invitationAccepted_BOTH.tmpl'
				asUrl ]
		raise: ZnCharacterEncodingError
]
