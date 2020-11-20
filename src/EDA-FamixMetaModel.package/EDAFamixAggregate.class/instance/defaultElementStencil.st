view
defaultElementStencil

	^ BlElement new
		geometry: BlEllipse new;
		background: Color transparent ;
		border: (BlBorder paint: Color black);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 10).
			c horizontal fitContent.
			c vertical fitContent ]