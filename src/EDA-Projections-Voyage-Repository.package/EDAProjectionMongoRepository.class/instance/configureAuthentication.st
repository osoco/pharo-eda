accessing
configureAuthentication
	self flag: #TODO.	"Find out how to customize the authentication of the specific Mongo instance"
	self class authenticationMechanism beDefault.
