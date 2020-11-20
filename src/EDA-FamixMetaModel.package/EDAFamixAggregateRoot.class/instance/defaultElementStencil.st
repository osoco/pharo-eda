view
defaultElementStencil

	^ BlElement new
		geometry: BlEllipse new;
		background: (Color red alpha: 0.6);
		border: (BlBorder paint: Color black);
		constraintsDo: [ :c | c padding: (BlInsets all: 10) ]