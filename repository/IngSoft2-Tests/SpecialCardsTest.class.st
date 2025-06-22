Class {
	#name : 'SpecialCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
	aGame apllyEffect: speedCard To: 1.
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
	aGame apllyEffect: accelerationCard To: 0.
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
	aGame apllyEffect: speedCard To: 1.
	aGame apllyEffect: speedCard To: 1.	
	aGame start.

	self assert: (aGame positionOf:1) equals:4
]
