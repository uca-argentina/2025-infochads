Class {
	#name : 'PositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PositionTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
PositionTest >> testWhenAPositionIsCreatedWithCeroThenCreationFails [

	self
		should: [ Position at: 0 ]
		raise: Error
		withMessageText: 'The position must be positive'
]

{ #category : 'tests' }
PositionTest >> testWhenAPositionIsCreatedWithNegativeValuesThenCreationFails [

	self
		should: [ Position at: -10 ]
		raise: Error
		withMessageText: 'The position must be positive'
]

{ #category : 'tests' }
PositionTest >> testWhenAPositionIsCreatedWithNotIntThenCreationFails [

	self
		should: [ Position at: 'a' ]
		raise: Error
		withMessageText: 'The position must be positive'
]
