Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: anError raise: anErrorClass withMessageText: anErrorMessage [ 
	 self
        should: anError 
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                anErrorMessage ]

]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreated [

	| aBoard |
	aBoard := Board new.
	self assert: aBoard notNil
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithASizeZeroThenIsNotValid [

	self
		should: [ Board withSize: 0 andWormHolePosition: {  } ]
		raise: Error
		withMessageText: 'Board Size must be over 0.'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithAStringSizeThenIsNotValid [

	self
		should: [ Board withSize: '3' andWormHolePosition: {  } ]
		raise: Error
		withMessageText: 'Board Size must be a positive interger.'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithCertainSize [

	| aBoard |
	aBoard := Board withSize: 13 andWormHolePosition: {  } .
	self assert: aBoard boardSize equals: 13
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNegativeSizeThenIsNotValid [

	self
		should: [ Board withSize: -5 andWormHolePosition: {  } ]
		raise: Error
		withMessageText: 'Board Size must be over 0.'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNoSizeThenIsInValid [

	self should: [ Board new boardSize ] raise: Error
]
