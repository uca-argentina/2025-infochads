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
		should: [
			Board
				withSize: 0
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				andACellConfiguration: {  } ]
		raise: Error
		withMessageText: 'Board Size must be a positive interger.'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithAStringSizeThenIsNotValid [

	self
		should: [
			Board
				withSize: '3'
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				andACellConfiguration: {  } ]
		raise: Error
		withMessageText: 'Board Size must be a positive interger.'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithCertainSize [

	| aBoard |
	aBoard := Board
		          withSize: 13
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	self assert: aBoard boardSize equals: 13
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithNegativeSizeThenIsNotValid [

	self
		should: [
			Board
				withSize: -5
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				andACellConfiguration: {  } ]
		raise: Error
		withMessageText: 'Board Size must be a positive interger.'
]
