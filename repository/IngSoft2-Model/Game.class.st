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
Game class >> lapsMustBePositive: aNumberOfLaps [

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
	self lapsMustBePositive: aNumberOfLaps.

	^ self new
		  initializeWithBoardSize: aBoard
		  by: aNumberOfSpaceShips
		  thorwing: aDiceSet
		  wonAfter: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: spaceShip1 and: spaceShip2 [

	| throwSpaceShip1 throwSpaceShip2 |
	[
	throwSpaceShip2 := diceSet toss.
	throwSpaceShip1 := diceSet toss.
	throwSpaceShip1 = throwSpaceShip2 ] whileTrue: [  ].
	throwSpaceShip1 < throwSpaceShip2
		ifTrue: [ spaceShip1 lostBattle ]
		ifFalse: [ spaceShip2 lostBattle ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           ship1 getLaps -> ship1 getPosition
		           > (ship2 getLaps -> ship2 getPosition) ].

	^ (ranking collect: [ :each |
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
Game >> lapOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getLaps
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	aSpaceShip getPosition = 1 ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	(opponentShip == aSpaceShip) ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: diceRoll [

	(self skippingTurn: aSpaceShip after: diceRoll) ifTrue: [ ^ self ].

	aSpaceShip goToTemporaryPosition: diceRoll.

	board adjust: spaceShips positionAnd: laps.

	board checkForPowerUps: aSpaceShip andAllSpaceShips: spaceShips.

	board adjust: spaceShips positionAnd: laps.

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship | ship getPosition = aSpaceShip getPosition ]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getPosition.
]

{ #category : 'informationTest' }
Game >> shieldOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'as yet unclassified' }
Game >> skippingTurn: aSpaceShip after: aDiceRoll [

	^ aSpaceShip skipTurns or: (aSpaceShip skipATurn: aDiceRoll)
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll spaceShip |
	diceRoll := diceSet toss.
	"-1 allows to stop the rigged dice"
	[ self isGameOver or: diceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.

		self move: spaceShip after: diceRoll.
		
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
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
