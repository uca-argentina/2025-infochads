Class {
	#name : 'CardSystemTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardSystemTest >> testWhen [

	| aGame aDiceSet aBoard deck |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.

	deck := {Speed new. Redo new}.

	
	"Jugador 1 tiene mazo"
	"Jugador 1 quiere usar carta de su mazo"
	"Game chequea que haya carta en su mazo"
	"Jugador 1 usa carta de su mazo"
	"Jugador 1 pierde carta de su mazo"
	
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: deck.
	
	aGame useCard: Speed new from: 1 applyTo: 1.

	aGame start.

	"self assert:."
	self assert: (aGame positionOf: 1) equals: 3.
]

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
		         wonAfter: 1
					withDeck: { }.

	aGame start.
 "REFACTOR CAMBIAR EL = 2"


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
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: deck.



	aGame start.

	self assert: aGame getShipHands
]
