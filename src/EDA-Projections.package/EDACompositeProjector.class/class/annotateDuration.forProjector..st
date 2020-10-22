api
annotateDuration: aDuration forProjector: aProjector
	self executions at: aProjector put: aDuration.
	self
		logInfoMessage:
			'Projection of ' , aProjector greaseString , ' took '
				, aDuration greaseString