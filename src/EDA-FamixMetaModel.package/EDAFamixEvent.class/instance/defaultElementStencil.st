view
defaultElementStencil

	^ BlElement new
		geometry: BlEllipse new;
		background: Color yellow;
		border: (BlBorder paint: Color black);
		constraintsDo: [ :c | c padding: (BlInsets all: 10) ]