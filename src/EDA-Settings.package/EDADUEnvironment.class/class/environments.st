api
environments
	^ (FileLocator imageDirectory fullPath asFileReference / 'config') allChildren
		select: [ :f | f basename endsWith: '.json' ]
		thenCollect: [ :f | self removeSuffix: '.json' from: f basename ]