Extension { #name : #Exception }

{ #category : #'*EDA-Traits' }
Exception >> extraContextInformationForCommand: aCommand [
	^ Dictionary
		with: #command -> aCommand
]
