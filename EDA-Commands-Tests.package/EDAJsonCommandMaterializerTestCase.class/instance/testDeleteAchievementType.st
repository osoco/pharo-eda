as yet unclassified
testDeleteAchievementType
	| applicationKey actualCommand achievementKey
	  aggregateRootVersion deleteCommandMessage
	  expectedCommand authorUsername |
	applicationKey := 'app-1'.
	achievementKey := 'ELITE.'.
	authorUsername := 'user1'.
	aggregateRootVersion := 1.
	deleteCommandMessage := '
	{
	  "name": "DELETE_ACHIEVEMENT_TYPE",
	  "commandId": "command-3",
	  "aggregateRootVersion": ' , aggregateRootVersion asString , ',
	  "authorUsername": "' , authorUsername , '",
	  "params": {
	    "applicationKey": "' , applicationKey , '",
		 "achievementTypeKey": "' , achievementKey , '",
		 "cascade": false
	  }
	}'.
	expectedCommand :=
	    GCDeleteAchievementType new
	        commandId: 'command-3';
	        aggregateRootVersion: aggregateRootVersion;
	        authorUsername: authorUsername;
	        applicationKey: applicationKey;
	        achievementTypeKey: achievementKey.
	actualCommand :=
	    EDAJsonCommandMaterializer new
	    materialize: deleteCommandMessage.
	self assert: actualCommand equals: expectedCommand.
	