Class {
	#name : #EDATLanguageHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATLanguageHelper',
	#classTraits : 'EDATLanguageHelper classTrait',
	#category : 'EDA-Traits-Tests'
}

{ #category : #tests }
EDATLanguageHelperTest >> testNounInPlural [
	self assert: (self nounInPlural: 'applicant') equals: 'applicants'.
	self assert: (self nounInPlural: 'applicants') equals: 'applicants'.
	self assert: (self nounInPlural: 'contest') equals: 'contests'.
	self assert: (self nounInPlural: 'contests') equals: 'contests'.
	self assert: (self nounInPlural: 'country') equals: 'countries'.
	self assert: (self nounInPlural: 'countries') equals: 'countries'.
	self assert: (self nounInPlural: 'evaluation') equals: 'evaluations'.
	self assert: (self nounInPlural: 'evaluations') equals: 'evaluations'.
	self assert: (self nounInPlural: 'evaluator') equals: 'evaluators'.
	self assert: (self nounInPlural: 'evaluators') equals: 'evaluators'.
	self assert: (self nounInPlural: 'round') equals: 'rounds'.
	self assert: (self nounInPlural: 'rounds') equals: 'rounds'.
	self assert: (self nounInPlural: 'skilltype') equals: 'skilltypes'.
	self assert: (self nounInPlural: 'skilltypes') equals: 'skilltypes'.
	self assert: (self nounInPlural: 'bus') equals: 'buses'.
	self assert: (self nounInPlural: 'buses') equals: 'buses'
]

{ #category : #tests }
EDATLanguageHelperTest >> testNounInSingular [
	self assert: (self nounInSingular: 'applicants') equals: 'applicant'.
	self assert: (self nounInSingular: 'applicant') equals: 'applicant'.
	self assert: (self nounInSingular: 'contests') equals: 'contest'.
	self assert: (self nounInSingular: 'contest') equals: 'contest'.
	self assert: (self nounInSingular: 'countries') equals: 'country'.
	self assert: (self nounInSingular: 'country') equals: 'country'.
	self assert: (self nounInSingular: 'evaluations') equals: 'evaluation'.
	self assert: (self nounInSingular: 'evaluation') equals: 'evaluation'.
	self assert: (self nounInSingular: 'evaluators') equals: 'evaluator'.
	self assert: (self nounInSingular: 'evaluator') equals: 'evaluator'.
	self assert: (self nounInSingular: 'rounds') equals: 'round'.
	self assert: (self nounInSingular: 'round') equals: 'round'.
	self assert: (self nounInSingular: 'skilltypes') equals: 'skilltype'.
	self assert: (self nounInSingular: 'skilltype') equals: 'skilltype'.
	self assert: (self nounInSingular: 'buses') equals: 'bus'.
	self assert: (self nounInSingular: 'bus') equals: 'bus'
]

{ #category : #tests }
EDATLanguageHelperTest >> testRemovePrefix [
	self assert: (self removePrefix: 'SKILL' from: 'SKILL_TYPE') equals: '_TYPE'.
	self assert: (self removePrefix: 'file://' from: 'file:///home/whatever') equals: '/home/whatever'
]

{ #category : #tests }
EDATLanguageHelperTest >> testRemoveSuffix [
	self assert: (self removeSuffix: 'TYPE' from: 'SKILL_TYPE') equals: 'SKILL_'.
	self assert: (self removeSuffix: ':8080' from: 'http://server:8080') equals: 'http://server'
]

{ #category : #tests }
EDATLanguageHelperTest >> testVerbInPresentTense [
	self assert: (self verbInPresentTense: 'created') equals: 'create'
]
