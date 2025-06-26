Class {
	#name : 'CardSystemTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CardSystemTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
CardSystemTest >> testWhenACardEffectIsAppliedThenIsRemovedFromShipDeck [

	| aGame aDiceSet aBoard deck |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.

	deck := {Speed new. Redo new}.

	
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: deck.
	
	aGame useCard: Speed new from: 1 applyTo: 1.

	aGame start.

	self assert: (aGame getCardDeckSizeOf: 1) equals: 1.
	self assert: (aGame positionOf: 1) equals: 3.
]

{ #category : 'tests' }
CardSystemTest >> testWhenAShipLandsOnACardGiverCellThenReceivesACard [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 100. 0. 3. 30. 20. 10 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.
		
		
		aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	aGame start.
	self assert: (aGame getCardDeckSizeOf: 1) equals: 3.

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
CardSystemTest >> testWhenCardGiverCellExistsWithItsProbabilitiesThenPreviousProbabilitiesAreNowInvalid [

	| aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 2. 2. 2. 5 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 40. 20. 20. 8. 2. 10. 10. 100. 3. 30. 20. 10 }.

	self
		should: [
			Board
				withSize: 100
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				andACellConfiguration: aConfigureDiceSet ]
		raise: Error
		withMessageText: 'The probabilites dont sum 100.'

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

{ #category : 'tests' }
CardSystemTest >> testWhenRedoCardIsUsedByShipAndDueToNoCardEffectUsedBeforeRedoIsNotUsed [

	| aGame aDiceSet aBoard deck |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.

	deck := { Speed new. Redo new }.

	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
		         withDeck: deck.

	

	self
		should: [ aGame useCard: Redo new from: 1 applyTo: 1 ]
		raise: Error
		withMessageText:
		'Redo Card not Used. No Card Effect Has Been Used Before Redo.'.
		
	self assert: (aGame getCardDeckSizeOf: 1) equals: 2.
]

{ #category : 'tests' }
CardSystemTest >> testWhenShipTriesToUseACancellationCardButThereIsNoPermanentEffectActiveSoItsNotConsumed [

	| aGame aDiceSet aBoard deck |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.

	deck := { Speed new. Cancellation new }.


	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
		         withDeck: deck.

	

	self
		should: [ aGame useCard: Cancellation new from: 1 applyTo: 1 ]
		raise: Error
		withMessageText:
		'There is no Permanent effect active, Cancelleation Card not Used.'.
		
	self assert: (aGame getCardDeckSizeOf: 1) equals: 2.
]
