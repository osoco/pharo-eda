accessing
ack: val
	self assert: (#(#auto #client #'client-individual') includes: val).
	ack := val