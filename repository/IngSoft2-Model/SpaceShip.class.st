Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'position',
		'temporaryPosition',
		'spaceShipID',
		'skipTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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
	skipTurns := 0.
	^ self
]

{ #category : 'as yet unclassified' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ skipTurns := 2 ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> lostBattle [

	self updatePosition: 0.
	self loseShield
]

{ #category : 'accessing' }
SpaceShip >> skipTurns [

	skipTurns ~= 0
		ifTrue: [
			skipTurns := skipTurns - 1.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> updatePosition: aNewPosition [

	position := aNewPosition.
	temporaryPosition := position
]

{ #category : 'as yet unclassified' }
SpaceShip >> updateTemporaryPosition: aNewTemporaryPosition [

	temporaryPosition := aNewTemporaryPosition
]
