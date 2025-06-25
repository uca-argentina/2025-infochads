Class {
	#name : 'CardSystemTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardSystemTest >> testWhenAllSpaceShipsInGameStartWith2CardsOnHand [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame getShipHands
]

{ #category : 'tests' }
CardSystemTest >> testWhenGameIsGivenFixedDeckForFurtherTesting [

	| aGame aDiceSet aBoard deck |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	deck := {Speed new. Redo new}.
	aGame := Game new.
	aGame useTestDeck: deck.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame useTestDeck: { Speed new. Redo new}.

	aGame start.

	self assert: aGame getShipHands
]
