Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'position',
		'temporaryPosition',
		'spaceShipID',
		'loseTurn',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShip >> adjustLapAndPositionRelativeTo: boardSize [

	| tempPos |
	tempPos := self getTemporaryPosition.
	self updateLap: tempPos // boardSize.
	self updateTemporaryPosition: tempPos \\ boardSize
]

{ #category : 'new methods' }
SpaceShip >> finishAt: finalPosition withLaps: finalLaps [

	temporaryPosition := finalPosition.
	laps := finalLaps
]

{ #category : 'getters' }
SpaceShip >> getLaps [
	^laps
]

{ #category : 'getters' }
SpaceShip >> getPosition [

	^ position
]

{ #category : 'getters' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'getters' }
SpaceShip >> getTemporaryPosition [

	^ temporaryPosition
]

{ #category : 'new methods' }
SpaceShip >> goToTemporaryPosition: positionsToSum [

	temporaryPosition := position + positionsToSum
]

{ #category : 'testing' }
SpaceShip >> hasReachedMaxProgressFor: totalLaps boardSize: boardSize [

	^ self getTemporaryPosition + (self getLaps * boardSize)
	  >= (totalLaps * boardSize)
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitialPosition: aPosition andID: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	position := aPosition.
	temporaryPosition := aPosition.
	loseTurn := 0.
	laps := 0.
	^ self
]

{ #category : 'testing' }
SpaceShip >> isBeforeBoardStart: aBoardSize [

	^ self getTemporaryPosition < aBoardSize
]

{ #category : 'as yet unclassified' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ loseTurn := 2 ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> lostBattle [

	self returnToBeginingOfLap.
	self loseShield
]

{ #category : 'as yet unclassified' }
SpaceShip >> rechargableShield: aDiceRoll [

	(shield = 3 and: aDiceRoll = 0) ifTrue: [
		Error signal: 
			'The Shield is already full, it cant be recharged.' ]
]

{ #category : 'new methods' }
SpaceShip >> returnToBeginingOfLap [

	position := 1.
	temporaryPosition := position
]

{ #category : 'as yet unclassified' }
SpaceShip >> skipATurn: aDiceRoll [

	self rechargableShield: aDiceRoll.
	aDiceRoll = 0
		ifTrue: [
			shield := 3.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'accessing' }
SpaceShip >> skipTurns [

	loseTurn ~= 0
		ifTrue: [
			loseTurn := loseTurn - 1.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'update' }
SpaceShip >> updateLap: numberOfLaps [

	laps := laps + numberOfLaps
]

{ #category : 'update' }
SpaceShip >> updatePosition [

	position := temporaryPosition.
]

{ #category : 'update' }
SpaceShip >> updateTemporaryPosition: aNewTemporaryPosition [

	temporaryPosition := aNewTemporaryPosition
]
