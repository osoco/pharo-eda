accessing
announcer
	EDALogEventAnnouncer ifNil: [ EDALogEventAnnouncer := Announcer new ].
	^ EDALogEventAnnouncer
