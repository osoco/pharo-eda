private
mapping
    "Retrieves the mapping, initializing it if necessary"
    Mapping ifNil: [ self initializeMapping ].
    ^ Mapping.
