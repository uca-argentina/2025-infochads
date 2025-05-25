Class {
	#name : 'RankingTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RankingTest >> testWhenGameIsOverAndSpaceShip2Wins [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 9 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1.

	aGame start.
	
	self assert: aGame isOver.
	self assert: (aGame getRanking) first equals: 2.
	
]

{ #category : 'tests' }
RankingTest >> testWhenGameIsOverAndWinnerIsShip1 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6. }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1.

	aGame start.
	
	self assert: aGame isOver.
	self assert: (aGame getRanking) first equals: 1.
	
]

{ #category : 'tests' }
RankingTest >> testWhenGameIsOverInformsSpaceShipsPositionAndWhichLap [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6. }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1.

	aGame start.
	
	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 11.
	self assert: (aGame inWhichLapIsSpaceShip: 1) equals:1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3.
	self assert: (aGame inWhichLapIsSpaceShip: 2) equals:0.	
	
]
