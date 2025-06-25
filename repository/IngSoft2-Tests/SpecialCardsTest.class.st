Class {
	#name : 'SpecialCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpecialCardsTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenACancellationCardIsAppliedThenAShipLosesAnEffect [

	| aGame aDiceSet aBoard  cancellationCard accelerationCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }. 
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	
	cancellationCard := Cancellation new.
	accelerationCard := Acceleration new.
	cancellationCard effectTypeToCancel: accelerationCard .
	aGame applyEffect: accelerationCard to: 0.
	aGame applyEffect: cancellationCard to: 1.
	
	aGame start.

	self assert: (aGame positionOf:1) equals: 2
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenAShipWithMercenaryLosesBothLoseShield [

	| aGame aDiceSet aBoard mercenaryCard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2. 4. 6 }. "nave, atacado, mercenario de nave"
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4 
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard to: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard to: 2.
	aGame chooseMercenary: 4 for: 2.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 3) equals: 2.
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenASpaceShipHas2MercenariesAndLosesThenBothMercenariesLoseShield [

	| aGame aDiceSet aBoard mercenaryCard mercenaryCard1 |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2. 4. 1. 6 }. "nave, atacado, mercenario de nave"
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 5
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	mercenaryCard := Mercenary new.
	mercenaryCard1 := Mercenary new.
	aGame applyEffect: mercenaryCard to: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard1 to: 1.
	aGame chooseMercenary: 5 for: 1.
	aGame applyEffect: mercenaryCard to: 2.
	aGame chooseMercenary: 4 for: 2.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame shieldOf: 5) equals: 2.
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenBothShipsHave2MercenariesInABattleAnd1LosesThenLosesShield [

	| aGame aDiceSet aBoard mercenaryCard mercenaryCard1 |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2. 4. 1. 6. 1 }. "nave, atacado, mercenario de nave"
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 6
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	mercenaryCard := Mercenary new.
	mercenaryCard1 := Mercenary new.
	aGame applyEffect: mercenaryCard to: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard1 to: 1.
	aGame chooseMercenary: 5 for: 1.
	aGame applyEffect: mercenaryCard to: 2.
	aGame chooseMercenary: 4 for: 2.
	aGame applyEffect: mercenaryCard1 to: 2.
	aGame chooseMercenary: 6 for: 2.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame shieldOf: 5) equals: 2.
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenRepeatCardIsUsedOnSpaceshipAnTheEffectToRepeatIsAtomicBomb [

	| aGame aDiceSet aBoard aConfigureDiceSet repeatCard |
	aDiceSet := RiggedDice new initializeWith: { 50. 10. }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 100. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 3
					withDeck: { }.
	repeatCard := Repeat new.
	aGame start.
	aGame applyEffect: repeatCard to: 1.
	self assert: (aGame positionOf: 1) equals: 0.
	self assert: (aGame shieldOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 0.
	self assert: (aGame shieldOf: 2) equals: 1
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenRepeatCardIsUsedOnSpaceshipAnTheEffectToRepeatIsBlackHole [

	| aGame aDiceSet aBoard aConfigureDiceSet repeatCard |
	aDiceSet := RiggedDice new initializeWith: { 20 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	repeatCard := Repeat new.
	aGame start.
	aGame applyEffect: repeatCard to: 1.
	self assert: (aGame positionOf: 1) equals: 13
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenShipUses2RedoCardsThatTransformsIntoASpeedCardDueToBeingLastCardUsed [

	| aGame aDiceSet aBoard  speedCard redoCard redoCard1 |
	aDiceSet := RiggedDice new initializeWith: { 1 }. 
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	speedCard := Speed new.
	redoCard := Redo new.
	redoCard1 := Redo new.
	aGame applyEffect: speedCard to: 1.
	aGame applyEffect: redoCard to: 1.	
	aGame applyEffect: redoCard1 to: 1.	
	aGame start.

	self assert: (aGame positionOf:1) equals: 5
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenShipUsesARedoCardThatTransformsIntoASpeedCardDueToBeingLastCardUsed [

	| aGame aDiceSet aBoard  speedCard redoCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }. 
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	speedCard := Speed new.
	redoCard := Redo new.
	aGame applyEffect: speedCard to: 1.
	aGame applyEffect: redoCard to: 1.	
	aGame start.

	self assert: (aGame positionOf:1) equals:4
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShip1HasMercenaryCardAndWinsBattleAgainst2 [

	| aGame aDiceSet aBoard mercenaryCard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2. 4 }. "nave, atacado, mercenario de nave"
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

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard to: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 2.
	self assert: (aGame shieldOf: 1) equals: 3.
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShip2And1HasMercenaryCardAnd2WinsBattleAgainst1 [

	| aGame aDiceSet aBoard mercenaryCard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2. 4. 6 }. "nave, atacado, mercenario de nave"
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard to: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard to: 2.
	aGame chooseMercenary: 4 for: 2.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame shieldOf: 1) equals: 2.
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShipHasASpeedCardEffectAppliedThenMovesAnExtraPositionThanShownInDiceRoll [

	| aGame aDiceSet aBoard speedCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	speedCard := Speed new.
	aGame applyEffect: speedCard to: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShipHasAnAccelerationCardEffectThenMovesAnExtraPositionThanShownInDiceRoll [

	| aGame aDiceSet aBoard accelerationCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	accelerationCard := Acceleration new.
	aGame applyEffect: accelerationCard to: 0.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShipHasMoreThan1SpeedEffectThenMovesExtraPositionAcordingToAmountOfSpeedEffectsApplied [

	| aGame aDiceSet aBoard speedCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	speedCard := Speed new.
	aGame applyEffect: speedCard to: 1.
	aGame applyEffect: speedCard to: 1.	
	aGame start.

	self assert: (aGame positionOf:1) equals:4
]

{ #category : 'tests' }
SpecialCardsTest >> testWhenSpaceShipHasNoPermanentEffectActiveTriesUsingCancellationCardThenIsInvalid [

	| aGame aDiceSet aBoard cancellationCard accelerationCard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	cancellationCard := Cancellation new.
	accelerationCard := Acceleration new.
	cancellationCard effectTypeToCancel: accelerationCard.

	self
		should: [ aGame applyEffect: cancellationCard to: 1 ]
		raise: Error
		withMessageText:
		'There is no Permanent effect active, Cancelleation Card not Used.'
]
