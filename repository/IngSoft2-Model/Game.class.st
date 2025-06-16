Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> lapsMustBePositiveInteger: aNumberOfLaps [

	(aNumberOfLaps isInteger and: [ aNumberOfLaps > 0 ]) ifFalse: [
		self error: 'Laps must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips [

	(aNumberOfSpaceShips isInteger not or: [
		 aNumberOfSpaceShips negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> playedIn: aBoard by: aNumberOfSpaceShips throwing: aDiceSet wonAfter: aNumberOfLaps [

	self numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	self lapsMustBePositiveInteger: aNumberOfLaps.

	^ self new
		  initializeWithBoardSize: aBoard
		  by: aNumberOfSpaceShips
		  thorwing: aDiceSet
		  wonAfter: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: arg1 and: arg2 [

	| tmp1 tmp2 |
	[
	tmp2 := diceSet toss.
	tmp1 := diceSet toss.
	tmp1 = tmp2 ] whileTrue: [  ].
	tmp1 < tmp2
		ifTrue: [ arg1 lostBattle ]
		ifFalse: [ arg2 lostBattle ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           ship1 getLaps -> ship1 getPosition
		           > (ship2 getLaps -> ship2 getPosition) ].

	^ ((ranking first: (ranking size min: 3)) collect: [ :each |
		   each getID ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.
	self startingPositions: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.
	^ self
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  aShip getPosition = board boardSize and: aShip getLaps = laps ]
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOfSpaceShip: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getLaps
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	aSpaceShip getPosition = 1 ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	opponentShip ifNotNil: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips select: [ :ship | ship ~= aSpaceShip ].

	^ otherShips
		  detect: [ :ship | ship getPosition = aSpaceShip getPosition ]
		  ifNone: [ nil ]
]

{ #category : 'informationTest' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getPosition.
]

{ #category : 'informationTest' }
Game >> shieldStatus: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'as yet unclassified' }
Game >> skippingTurns: aSpaceShip withRoll: aDiceRoll [

	^ aSpaceShip skipTurns or: (aSpaceShip skipATurn: aDiceRoll)
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll spaceShip |
	diceRoll := diceSet toss.
	[ self isGameOver or: diceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.

		self the: spaceShip hasRolled: diceRoll.
		
		self updateNextShipToMove: nextSpaceShipToMove.
		diceRoll := diceSet toss ]
]

{ #category : 'whats left of race positions' }
Game >> startingPositions: aNumberOfSpaceShips [
	
	spaceShips := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :id |
		spaceShips add: (SpaceShip new
				 initializeWithShield: 3
				 andInitialPosition: 1
				 andID: id) ].
	1.
]

{ #category : 'as yet unclassified' }
Game >> the: aSpaceShip hasRolled: diceRoll [

	(self skippingTurns: aSpaceShip withRoll: diceRoll) ifTrue: [ ^ self ].

	aSpaceShip goToTemporaryPosition: diceRoll.

	board adjust: spaceShips positionAnd: laps.

	board checkForPowerUps: aSpaceShip andAllSpaceShips: spaceShips.

	board adjust: spaceShips positionAnd: laps.

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
