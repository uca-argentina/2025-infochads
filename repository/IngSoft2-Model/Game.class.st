Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'aBoard',
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> lapsMustBePositiveInteger: arg1 [

	(arg1 isInteger and: [ arg1 > 0 ]) ifFalse: [
		self error: 'Laps must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBeAtLeastOne: arg1 [

	arg1 <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBePositiveInteger: arg1 [

	(arg1 isInteger not or: [ arg1 negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips withDiceSet: aDiceSet withWormHole: aWormHolePosition withAmountOfLaps: aLapsCount withCellConfigurations: boardCellConfiguration [

	self numberOfSpaceShipsMustBePositiveInteger: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	self lapsMustBePositiveInteger: aLapsCount.

	^ self new
		  initializeWithBoardSize: aBoardSize
		  AndNumberOfSpaceShips: aNumberOfSpaceShips
		  AndDiceSet: aDiceSet
		  AndWormHole: aWormHolePosition
		  Andlaps: aLapsCount
		  AndConfiguration: boardCellConfiguration
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
Game >> initializeWithBoardSize: aBoardSize AndNumberOfSpaceShips: aNumberOfSpaceShips AndDiceSet: aDiceSet AndWormHole: aWormHolePosition Andlaps: aLapsCount AndConfiguration: aConfigDiceSet [

	aBoard := Board
		          withSize: aBoardSize
		          andWormHolePosition: aWormHolePosition
		          andCellConfiguration: aConfigDiceSet.
	spaceShips := self startingPositions: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aLapsCount.
	^ self
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  aShip getPosition = aBoard boardSize and: aShip getLaps = laps ]
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
Game >> startingPositions: arg1 [

	| tmp1 |
	tmp1 := OrderedCollection new.
	1 to: arg1 do: [ :tmp2 |
		tmp1 add: (SpaceShip new
				 initializeWithShield: 3
				 andInitialPosition: 1
				 andID: tmp2) ].
	1.
	^ tmp1
]

{ #category : 'as yet unclassified' }
Game >> the: aSpaceShip hasRolled: diceRoll [

	(self skippingTurns: aSpaceShip withRoll: diceRoll) ifTrue: [ ^ self ].

	aSpaceShip goToTemporaryPosition: diceRoll.

	aBoard adjust: spaceShips positionAnd: laps.

	aBoard checkForPowerUps: aSpaceShip andAllSpaceShips: spaceShips.

	aBoard adjust: spaceShips positionAnd: laps.

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
