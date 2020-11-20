view
defaultElementStencil

	^ BlElement new
		geometry: BlEllipse new;
		background: Color green;
		border: (BlBorder paint: Color black);
		constraintsDo: [ :c | c padding: (BlInsets all: 10) ]