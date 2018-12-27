api
generate
	self generatorClasses
		keysAndValuesDo: [ :index :generatorClass | 
			| generator |
			generator := generatorClass
				fromExampleFile: self commandFile
				version: self version
				appName: self appName
				aggregate: self aggregate
				andEventNameResolver: self eventNameResolver.
			generator generate ]
		displayingProgress: [ :index :generatorClass | 'Generating via ' , generatorClass greaseString , ' (v' , self version greaseString , ')' ]