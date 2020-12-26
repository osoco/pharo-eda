accessing
lazySynchronize
	lazySynchronize ifNil: [ self lazySynchronize: false ].
	^ lazySynchronize