Class {
	#name : #EDAProjectionMemoryRepository,
	#superclass : #EDAProjectionVoyageRepository,
	#category : #'EDA-Projections-Voyage-Repository'
}

{ #category : #accessing }
EDAProjectionMemoryRepository >> configureAuthentication [

]

{ #category : #persistence }
EDAProjectionMemoryRepository >> convertDictonaryToConditionalBlock: aDictionary [
	| aBlock |
	aBlock := [ :each | aDictionary associations allSatisfy: [ :association | (each perform: association key asSymbol) = association value ] ].
	^ aBlock
]

{ #category : #persistence }
EDAProjectionMemoryRepository >> initBackendRepository [
	| result |
	result := VOMemoryRepository new.
	result enableSingleton.
	^ result
]

{ #category : #persistence }
EDAProjectionMemoryRepository >> selectMany: aProjectionClass where: aDictionary [
	^ aProjectionClass selectMany: (self convertDictonaryToConditionalBlock: aDictionary)
]

{ #category : #persistence }
EDAProjectionMemoryRepository >> selectOfTenant: aTenant many: aProjectionClass where: aDictionary [
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ self selectMany: aProjectionClass where: aDictionary
]

{ #category : #persistence }
EDAProjectionMemoryRepository >> selectOfTenant: aTenant one: aProjectionClass where: aDictionary [
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ self selectOne: aProjectionClass where: aDictionary
]

{ #category : #persistence }
EDAProjectionMemoryRepository >> selectOne: aProjectionClass where: aDictionary [
	^ aProjectionClass selectOne: (self convertDictonaryToConditionalBlock: aDictionary)
]
