Class {
	#name : 'PowerCellUnitTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PowerCellUnitTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenAtomicBombDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ AtomicBombEffect with: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be 0.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenAtomicBombReceiveADesplacementOtherThan0ThenCreationFails [

	self
		should: [ AtomicBombEffect with: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 0.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenBlackHoleDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ BlackHoleEffect withBackTrack: '10' .]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenBlackHoleReceiveADesplacementOtherThan4ThenCreationFails [

	self
		should: [ BlackHoleEffect withBackTrack: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperJumpDoesntReceiveAtLeastOneJumpValueThenCreationFails [

	self
		should: [ HyperJumpEffect with: 100 andParsec: #( ) ]
		raise: Error
		withMessageText: 'The Jump list must have at least one value.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperJumpDoesntReceiveTheJumpsInOrderThenCreationFails [

	self
		should: [ HyperJumpEffect with: 100 andParsec: #(4 5 3) ]
		raise: Error
		withMessageText: 'The Jump list must be in order.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperSpaceJumpDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ HyperSpaceJumpEffect with: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperSpaceJumpReceiveADesplacementOtherThan0ThenCreationFails [

	self
		should: [ HyperSpaceJumpEffect with: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenMoonWalkReceiveADesplacementNegativeThenCreationFails [

	self
		should: [ MoonWalkEffect with: -1 ]
		raise: Error
		withMessageText: 'The desplacement must be a posible value.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenMoonWalkReceiveADesplacementOf0ThenCreationFails [

	self
		should: [ MoonWalkEffect with: 0 ]
		raise: Error
		withMessageText: 'The desplacement must be a posible value.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenMoonWalkReceiveADesplacementOfNotAnIntegerThenCreationFails [

	self
		should: [ MoonWalkEffect with: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be a posible value.'
]
