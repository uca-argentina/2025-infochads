Class {
	#name : 'ShootingFieldTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShootingFieldTests >> testShooting [

	| aGame aBoard spaceships aDiceSet laps aBoardSize aWormHole aPosition anotherPosition |
	aPosition := 2.
	anotherPosition := 1.
	aWormHole := WormHole startingAt: aPosition endingAt: anotherPosition.
	aBoardSize:= 10.
	aBoard := Board withSize: aBoardSize composedOf: aWormHole andACellConfiguration: {}.
	
	spaceships := 2.
	aDiceSet := DiceSet withDices: { Dice withSides: 6.  Dice withSides: 6}. "Done"
	laps := 2.
	aGame := Game playedIn: aBoard by: spaceships throwing: aDiceSet wonAfter: laps.

]
