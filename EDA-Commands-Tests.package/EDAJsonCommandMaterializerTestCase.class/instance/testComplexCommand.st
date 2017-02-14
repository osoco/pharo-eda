as yet unclassified
testComplexCommand
	| applicationKey actualCommand
	  aggregateRootVersion complexCommandMessage
	  expectedCommand authorUsername |
	applicationKey := 'app-1'.
	authorUsername := 'user1'.
	aggregateRootVersion := 1.
	complexCommandMessage := '
	{
	  "name": "COMPLEX_COMMAND",
	  "commandId": "command-3",
	  "aggregateRootVersion": ' , aggregateRootVersion asString , ',
	  "authorUsername": "' , authorUsername , '",
	  "params": {
	    "applicationKey": "' , applicationKey , '",
		 "levels": [ { 
			   "levelName": "first",
			   "levelRangeSize": 100
		     },{
		         "levelName": "second"
		     }
		  ]
	  }
	}'.
	expectedCommand :=
	    EDAComplexCommand new
	        commandId: 'command-3';
	        aggregateRootVersion: aggregateRootVersion;
	        authorUsername: authorUsername;
	        applicationKey: applicationKey;
	        levels: { 
	            GCLevel new
	                levelName: 'first';
	                levelRangeSize: 100.
	            GCLevel new
	                levelName: 'second'.
	         } asOrderedCollection.
	EDACommandBuilderRegistry mapping at: 'COMPLEX_COMMAND' put: EDAComplexCommandBuilder new.
	actualCommand :=
	    EDAJsonCommandMaterializer new
	    materialize: complexCommandMessage.
	self assert: (actualCommand levels size) equals: 2.
	self assert: actualCommand equals: expectedCommand.