Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'Object',
	#instVars : [
		'displacement',
		'shieldsTaken'
	],
	#classInstVars : [
		'displacement',
		'shieldsTaken'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> modify: aSpaceShip orMaybe: allSpaceShips [

	aSpaceShip updateTemporaryPosition:
		aSpaceShip getTemporaryPosition + displacement.
	aSpaceShip loseShield
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> withDesplacementValue: aPosition andShieldsSacrificed: aNumberOfShields [

	displacement := aPosition.
	shieldsTaken := aNumberOfShields
]
