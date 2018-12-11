code generation
generateEqualsMethodFor: attributes
	"^ self generateNoAttributesEqualsMethodFor: attributes"
	^ self generateAttributesEqualsMethodFor: attributes.