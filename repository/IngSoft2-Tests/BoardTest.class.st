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
	
	|aBoard|
	aBoard := Board new.
	self assert: aBoard notNil.

]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithCertainSize [
	
	|aBoard|
	aBoard := Board withBoardSize: 13.
	self assert: aBoard boardSize equals:13

]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNegativeSizeThenIsNotValid [
	
	self
		should: [ Board withBoardSize: -5 ]
		raise: Error
		withMessageText: 'Board Size must be a positive interger'
]
