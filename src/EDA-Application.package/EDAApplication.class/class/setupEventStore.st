setup - events
setupEventStore
	self flag: #TODO.	"Find out how to customize the authentication of the specific Mongo instance"
	self eventStore: EDAMongoEventStore new.
	self configureEventStoreAuthentication