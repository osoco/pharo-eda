Class {
	#name : #EDATSettingsHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATSettingsHelper',
	#classTraits : 'EDATSettingsHelper classTrait',
	#category : 'EDA-Traits-Tests'
}

{ #category : #tests }
EDATSettingsHelperTest >> testFlattenedSettings [
	| actual env |
	env := {('a' -> 'b')} asDictionary.
	actual := self class retrieveSettingAsDict: 'a' using: env.
	self assert: actual equals: 'b'
]

{ #category : #tests }
EDATSettingsHelperTest >> testFlattenedSettingsWithDictionary [
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> 'e')} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c' using: env.
	self assert: (actual at: 'd' ifAbsent: nil) equals: 'e'
]

{ #category : #tests }
EDATSettingsHelperTest >> testNestedSettings [
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> {('e' -> 'f')} asDictionary)} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c/d' using: env.
	self assert: (actual at: 'e' ifAbsent: nil) equals: 'f'
]
