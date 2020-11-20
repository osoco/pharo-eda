view
defaultEdgeStencil
	^ BlLineElement new
		border: (BlBorder paint: (Color red) width: 1);
		constraintsDo: [ :c | c ignoredByLayout ];
		zIndex: -1;
		toHead:
			(BlArrowheadSimpleArrow new
				border:
					(BlBorder builder
						paint: (Color red);
						width: 6;
						build))