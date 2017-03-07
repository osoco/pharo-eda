instance creation
publisher: publisher serializer: serializer announcer: anAnnouncer
	^ self new
		publisher: publisher;
		serializer: serializer;
		announcer: anAnnouncer;
		yourself