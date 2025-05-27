Class {
	#name : 'RankingTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RankingTests >> testWhenGameIsNotOverThereIsNoRanking [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame getRanking equals: {  }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndShip1WinsAndShip2IsSecond [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6. 9 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 2 }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndShip1WinsAndShip3IsSecondAndShip2IsThird [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 6 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 3. 2 }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndSpaceShip2Wins [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 9 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking first equals: 2
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndWinnerIsShip1 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking first equals: 1
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverInformsSpaceShipsPositionAndWhichLap [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 11.
	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3.
	self assert: (aGame inWhichLapIsSpaceShip: 2) equals: 0
]

{ #category : 'tests' }
RankingTests >> testWhenGameThereAre4ShipsTheRankingOnlyShowsTheFirst3 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 7. 7 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 4
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: {  }.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 4. 3 }
]
