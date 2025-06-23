Class {
	#name : 'SpecialCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
		         wonAfter: 1.

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard To: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard To: 2.
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
		         wonAfter: 1.

	mercenaryCard := Mercenary new.
	mercenaryCard1 := Mercenary new.
	aGame applyEffect: mercenaryCard To: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard1 To: 1.
	aGame chooseMercenary: 5 for: 1.
	aGame applyEffect: mercenaryCard To: 2.
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
		         wonAfter: 1.

	mercenaryCard := Mercenary new.
	mercenaryCard1 := Mercenary new.
	aGame applyEffect: mercenaryCard To: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard1 To: 1.
	aGame chooseMercenary: 5 for: 1.
	aGame applyEffect: mercenaryCard To: 2.
	aGame chooseMercenary: 4 for: 2.
	aGame applyEffect: mercenaryCard1 To: 2.
	aGame chooseMercenary: 6 for: 2.
	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame shieldOf: 5) equals: 2.
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
		         wonAfter: 1.

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard To: 1.
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
		         wonAfter: 1.

	mercenaryCard := Mercenary new.
	aGame applyEffect: mercenaryCard To: 1.
	aGame chooseMercenary: 3 for: 1.
	aGame applyEffect: mercenaryCard To: 2.
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
		         wonAfter: 1.

	speedCard := Speed new.
	aGame applyEffect: speedCard To: 1.
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
		         wonAfter: 1.

	accelerationCard := Acceleration new.
	aGame applyEffect: accelerationCard To: 0.
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
		         wonAfter: 1.

	speedCard := Speed new.
	aGame applyEffect: speedCard To: 1.
	aGame applyEffect: speedCard To: 1.	
	aGame start.

	self assert: (aGame positionOf:1) equals:4
]
