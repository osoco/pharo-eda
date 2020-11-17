view
edgeStencil
	^ BlLineElement new
		border: (BlBorder paint: (Color gray alpha: 0.6));
		constraintsDo: [ :c | c ignoredByLayout ];
		zIndex: -1;
		toHead:
			(BlArrowheadSimpleArrow new
				border:
					(BlBorder builder
						paint: (Color gray alpha: 0.6);
						width: 6;
						build))