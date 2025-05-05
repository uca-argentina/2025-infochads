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
BoardTest >> testWhenBoardIsCreatedWithCertainSize [

	| aBoard |
	aBoard := Board withSize: 13 withNumberOfSpaceShips: 1.
	self assert: aBoard boardSize equals: 13
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNegativeSizeThenIsNotValid [

	self
		should: [ Board withSize: -5  withNumberOfSpaceShips: 1]
		raise: Error
		withMessageText: 'Board Size must be a positive interger'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNoSizeThenIsInValid [

	self should: [ Board new boardSize ] raise: Error
]
