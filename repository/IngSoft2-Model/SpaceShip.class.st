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
SpaceShip >> getLaps [
	^laps
]

{ #category : 'as yet unclassified' }
SpaceShip >> getPosition [

	^ position
]

{ #category : 'as yet unclassified' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'as yet unclassified' }
SpaceShip >> getTemporaryPosition [

	^ temporaryPosition
]

{ #category : 'as yet unclassified' }
SpaceShip >> goToTemporaryPosition: positionsToSum [

	temporaryPosition := position + positionsToSum
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitialPosition: aPosition andID: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	position := aPosition.
	temporaryPosition := aPosition.
	loseTurn := 0.
	laps := 1.
	^ self
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

{ #category : 'as yet unclassified' }
SpaceShip >> returnToBeginingOfLap [

	position := 0
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

{ #category : 'as yet unclassified' }
SpaceShip >> updateLap: numberOfLaps [

	laps := laps + numberOfLaps
]

{ #category : 'as yet unclassified' }
SpaceShip >> updatePosition [

	position := temporaryPosition.
]

{ #category : 'as yet unclassified' }
SpaceShip >> updateTemporaryPosition: aNewTemporaryPosition [

	temporaryPosition := aNewTemporaryPosition
]
