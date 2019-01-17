api
generate
	| generators |
	generators := self generatorClasses collect: [ :generatorClass |
		 generatorClass
				fromExampleFile: self commandFile
				version: self version
				appName: self appName
				aggregate: self aggregate
				commandNameResolver: self commandNameResolver
				andEventNameResolver: self eventNameResolver ].
	generators
		keysAndValuesDo: [ :index :generator | 
			generator generate ]
		displayingProgress:
			[ :index :generator | generator buildMessage ]