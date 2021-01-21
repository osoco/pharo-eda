Extension { #name : #VORepository }

{ #category : #'*EDA-Voyage-EventStore' }
VORepository >> disableSingleton [
	self class setRepository: nil
]
