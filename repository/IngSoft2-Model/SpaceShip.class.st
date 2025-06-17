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
SpaceShip class >> itMustHaveAnID: anId [

	(anId = '') ifTrue: [
		Error signal: 'The ship must be identifiable.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> itMustHaveThree: aShield [

	(aShield isInteger and: [ aShield = 3 ]) ifFalse: [
		Error signal: 'The ship must initialize with 3 shield.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> with: anId initial: aPosition andStartingWith: aShield [

	self itMustHaveThree: aShield.
	self itMustHaveAnID: anId.

	^ self new
		  initializeWithShield: aShield
		  andInitial: aPosition
		  and: anId
]

{ #category : 'laps and position' }
SpaceShip >> finishAt: finalPosition withLaps: finalLaps [

	temporaryPosition := finalPosition.
	laps := finalLaps
]

{ #category : 'getters' }
SpaceShip >> getID [

	^ spaceShipID
]

{ #category : 'getters' }
SpaceShip >> getLaps [

	^ laps
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

{ #category : 'positions' }
SpaceShip >> goToTemporaryPosition: positionsToSum [

	temporaryPosition := position + positionsToSum
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitial: aPosition and: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	position := aPosition.
	temporaryPosition := aPosition.
	loseTurn := 0.
	laps := 0.
	^ self
]

{ #category : 'shield' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ loseTurn := 2 ]
]

{ #category : 'accessing' }
SpaceShip >> lostBattle [

	self returnToBeginingOfLap.
	self loseShield
]

{ #category : 'shield' }
SpaceShip >> rechargableShield: aDiceRoll [

	(shield = 3 and: aDiceRoll = 0) ifTrue: [
		Error signal: 
			'The Shield is already full, it cant be recharged.' ]
]

{ #category : 'laps and position' }
SpaceShip >> returnToBeginingOfLap [

	position := 1.
	temporaryPosition := position
]

{ #category : 'accessing' }
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

{ #category : 'laps' }
SpaceShip >> updateLap: numberOfLaps [

	laps := laps + numberOfLaps
]

{ #category : 'positions' }
SpaceShip >> updatePosition [

	position := temporaryPosition.
]

{ #category : 'positions' }
SpaceShip >> updateTemporaryPosition: aNewTemporaryPosition [

	temporaryPosition := aNewTemporaryPosition
]
