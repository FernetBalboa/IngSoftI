!classDefinition: #TEGTest category: #TEG!
TestCase subclass: #TEGTest
	instanceVariableNames: 'invasion diceRoller'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!TEGTest methodsFor: 'auxiliars' stamp: 'FB 10/26/2017 13:55:03'!
invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls
	
	| attackerDice defenderDice diceRoller invasion |
	
	attackerDice _ attackerRolls size.
	defenderDice _ defenderRolls size.
	
	diceRoller _ InvasionDiceRoller	attacker: attackerRolls defender: defenderRolls.
	invasion _ Invasion with: diceRoller.
	
	^[invasion attacker: attackerDice defender: defenderDice.]! !


!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 13:57:05'!
test01DefenderWinsOnRollTie
	
	| invasion attackerRolls defenderRolls |

	attackerRolls _ OrderedCollection with: 1.
	defenderRolls _ OrderedCollection with: 1.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 1.
	self assert: invasion defenderLoses equals: 0.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 13:57:28'!
test02AttackerWinsIfRollsHigherThanDefender
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 2.
	defenderRolls _ OrderedCollection with: 1.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 0.
	self assert: invasion defenderLoses equals: 1.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 13:57:49'!
test03AttackerCanWinMoreThanOne
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 2 with: 2.
	defenderRolls _ OrderedCollection with: 1 with: 1.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 0.
	self assert: invasion defenderLoses equals: 2.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 13:59:28'!
test04AttackerCanWinOneAndLoseOne
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 2 with: 2.
	defenderRolls _ OrderedCollection with: 1 with: 3.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 1.
	self assert: invasion defenderLoses equals: 1.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 14:01:48'!
test05OrderOfRollsDoesNotMatter
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 4 with: 1 with: 5.
	defenderRolls _ OrderedCollection with: 4 with: 3 with: 3.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 1.
	self assert: invasion defenderLoses equals: 2.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 15:48:46'!
test06DefenderMayUseMoreDiceThanAttacker
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 4 with: 1.
	defenderRolls _ OrderedCollection with: 4 with: 3 with: 3.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 2.
	self assert: invasion defenderLoses equals: 0.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 15:50:34'!
test07AttackerMayUseMoreDiceThanDefender
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 2 with: 5 with: 6.
	defenderRolls _ OrderedCollection with: 4 with: 3.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 0.
	self assert: invasion defenderLoses equals: 2.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 16:12:23'!
test08DefenderWinsAllTies
	
	| invasion attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 2 with: 3 with: 4.
	defenderRolls _ OrderedCollection with: 2 with: 4 with: 3.
	
	invasion _ (self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.
	
	self assert: invasion attackerRolls equals: attackerRolls.
	self assert: invasion defenderRolls equals: defenderRolls.
	self assert: invasion attackerLoses equals: 3.
	self assert: invasion defenderLoses equals: 0.! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 16:46:34'!
test09SidesMustRollAtLeastOneDice
	
	| attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection new.
	defenderRolls _ OrderedCollection with: 2 with: 4 with: 3.

	self should: [self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'Both sides must roll at least one die'].
		
	attackerRolls _ OrderedCollection with: 1 with: 2 with: 3.
	defenderRolls _ OrderedCollection new.

	self should: [self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'Both sides must roll at least one die'].
		
	attackerRolls _ OrderedCollection new.
	defenderRolls _ OrderedCollection new.

	self should: [self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'Both sides must roll at least one die'].
	! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 16:51:17'!
test10RollsMustBeBetween1And6
	
	| attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 1 with: 4 with: 7.
	defenderRolls _ OrderedCollection with: 2 with: 4 with: 3.

	self should: [self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'All rolls values must be between 1 and 6'].
	
	attackerRolls _ OrderedCollection with: 1 with: 4 with: 6.
	defenderRolls _ OrderedCollection with: 0 with: -1 with: 3.

	self should: [self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'All rolls values must be between 1 and 6'].! !

!TEGTest methodsFor: 'testing' stamp: 'FB 10/26/2017 17:16:45'!
test11EachSideCanNotRollMoreThan3Dice
	
	| attackerRolls defenderRolls |
	
	attackerRolls _ OrderedCollection with: 1 with: 4 with: 5.
	attackerRolls add: 4.
	defenderRolls _ OrderedCollection with: 2.

	self should: [(self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'Each side can not roll more than 3 dice'].
	
	attackerRolls _ OrderedCollection with: 1 with: 4 with: 6.
	defenderRolls _ OrderedCollection with: 1 with: 2 with: 3.
	defenderRolls add: 4.

	self should: [(self invasionSimulationWithAttackerRolls: attackerRolls andDefenderRolls: defenderRolls) value.]
	       raise: Error
		  withExceptionDo: [:anError | self assert: anError messageText equals: 'Each side can not roll more than 3 dice'].! !


!classDefinition: #Invasion category: #TEG!
Object subclass: #Invasion
	instanceVariableNames: 'attackerDice defenderDice attackerLoses defenderLoses attackerRolls defenderRolls diceRoller'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!Invasion methodsFor: 'results inspection' stamp: 'FB 10/26/2017 10:18:47'!
attackerLoses

	^attackerLoses.! !

!Invasion methodsFor: 'results inspection' stamp: 'FB 10/26/2017 13:10:49'!
attackerRolls
	^ attackerRolls.! !

!Invasion methodsFor: 'results inspection' stamp: 'FB 10/26/2017 10:18:56'!
defenderLoses

	^defenderLoses.! !

!Invasion methodsFor: 'results inspection' stamp: 'FB 10/26/2017 13:11:07'!
defenderRolls
	^ defenderRolls.! !


!Invasion methodsFor: 'initialization' stamp: 'FB 10/26/2017 13:36:25'!
initializeWith: aDiceRoller

	diceRoller _ aDiceRoller.
	attackerLoses _ 0.
	defenderLoses _ 0.! !


!Invasion methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 17:08:34'!
attacker: attackerAmountOfDice defender: defenderAmountOfDice

	attackerDice _ attackerAmountOfDice.
	defenderDice _ defenderAmountOfDice.
	
	(attackerDice < 1 or: [defenderDice  < 1]) ifTrue: [ ^Error signal: self emptyRollsErrorMessage ].
	(attackerDice > 3 or: [defenderDice > 3]) ifTrue: [ ^Error signal: self tooManyDiceErrorMessage ].
	
	
	attackerRolls _ self rollAttackerDice: attackerDice.
	defenderRolls _ self rollDefenderDice: defenderDice.
	
	self attackerRolled: attackerRolls defenderRolled: defenderRolls.! !

!Invasion methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:16:59'!
rollAttackerDice: diceNumber

	^diceRoller rollAttackerDice: diceNumber.! !

!Invasion methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:38:09'!
rollDefenderDice: diceNumber

	^diceRoller rollDefenderDice: diceNumber.! !


!Invasion methodsFor: 'results control' stamp: 'FB 10/26/2017 16:09:02'!
attackerRolled: attackerRolls defenderRolled: defenderRolls

	|rollNumber sortedAttackerRolls sortedDefenderRolls minSize sortBlock |
	
	rollNumber _ 1.
	minSize _ attackerRolls size min: defenderRolls size.
	sortBlock _ [:roll1 :roll2 | roll1 > roll2 ].
	
	sortedAttackerRolls _ attackerRolls asSortedCollection: sortBlock.
	sortedDefenderRolls _ defenderRolls asSortedCollection: sortBlock.
	
	sortedAttackerRolls do: [ :attackerRoll | ((rollNumber <= minSize)  and: [attackerRoll <= (sortedDefenderRolls at: rollNumber)])
		ifTrue: [ self attackerLost ] 
		ifFalse: [ (rollNumber <= minSize) ifTrue: [self defenderLost] ].
		rollNumber _ rollNumber + 1].! !


!Invasion methodsFor: 'results control - private' stamp: 'FB 10/26/2017 13:42:30'!
attackerLost

	attackerLoses _ attackerLoses + 1.! !

!Invasion methodsFor: 'results control - private' stamp: 'FB 10/26/2017 13:42:46'!
defenderLost

	defenderLoses _ defenderLoses + 1.! !


!Invasion methodsFor: 'error messages - private' stamp: 'FB 10/26/2017 17:08:14'!
emptyRollsErrorMessage

	^'Both sides must roll at least one die'.! !

!Invasion methodsFor: 'error messages - private' stamp: 'FB 10/26/2017 17:01:49'!
tooManyDiceErrorMessage

	^'Each side can not roll more than 3 dice'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Invasion class' category: #TEG!
Invasion class
	instanceVariableNames: ''!

!Invasion class methodsFor: 'instance creation' stamp: 'FB 10/26/2017 11:19:09'!
with: aDiceRoller

	^self basicNew initializeWith: aDiceRoller.! !


!classDefinition: #InvasionDiceRoller category: #TEG!
Object subclass: #InvasionDiceRoller
	instanceVariableNames: 'attackerRolls defenderRolls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!InvasionDiceRoller methodsFor: 'setters - private' stamp: 'FB 10/26/2017 16:24:50'!
attackerRolls: anAttackerRollsCollection

	attackerRolls _ anAttackerRollsCollection.

	! !

!InvasionDiceRoller methodsFor: 'setters - private' stamp: 'FB 10/26/2017 16:24:39'!
defenderRolls: aDefenderRollsCollection

	defenderRolls _ aDefenderRollsCollection.

	! !


!InvasionDiceRoller methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:34:59'!
rollAttackerDice: diceNumber

	^self rollDice: diceNumber for: attackerRolls.
	! !

!InvasionDiceRoller methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:35:17'!
rollDefenderDice: diceNumber

	^self rollDice: diceNumber for: defenderRolls.
	! !

!InvasionDiceRoller methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:28:45'!
rollDice: diceNumber for: aRollsCollection

	| rolls |
	
	rolls _ OrderedCollection new.
	
	diceNumber timesRepeat: [ rolls add: (self rollDieFor: aRollsCollection).].
	
	^rolls.
	! !

!InvasionDiceRoller methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:14:46'!
rollDie

	^6 atRandom.! !

!InvasionDiceRoller methodsFor: 'dice rolling' stamp: 'FB 10/26/2017 12:29:05'!
rollDieFor: aRollsCollection
	"If collection is empty, roll a random dice number. Should not happen while testing"
	| roll |
	aRollsCollection isEmpty
		ifTrue: [ roll _ self rollDie ]
		ifFalse: [
			roll _ aRollsCollection first.
			aRollsCollection removeFirst ].
	^ roll.! !


!InvasionDiceRoller methodsFor: 'initialization' stamp: 'FB 10/26/2017 13:14:58'!
attackerRolls: attackerRollsCollection defenderRolls: defenderRollsCollection

	attackerRolls _ OrderedCollection newFrom: attackerRollsCollection.
	defenderRolls _ OrderedCollection newFrom: defenderRollsCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvasionDiceRoller class' category: #TEG!
InvasionDiceRoller class
	instanceVariableNames: ''!

!InvasionDiceRoller class methodsFor: 'error messages' stamp: 'FB 10/26/2017 16:31:14'!
emptyRollsErrorMessage

	^'Both sides must roll at least one die'.! !

!InvasionDiceRoller class methodsFor: 'error messages' stamp: 'FB 10/26/2017 16:54:01'!
invalidRollValueErrorMessage

	^'All rolls values must be between 1 and 6'.! !

!InvasionDiceRoller class methodsFor: 'error messages' stamp: 'FB 10/26/2017 17:02:08'!
tooManyDiceErrorMessage
	
	"Deberia estar aca?"
	
	^'Each side can not roll more than 3 dice'.! !


!InvasionDiceRoller class methodsFor: 'instance creation' stamp: 'FB 10/26/2017 17:14:15'!
attacker: attackerRollsCollection defender: defenderRollsCollection
	
	"Allows setting the attacker and defender rolls with no randomization"
	
	| minRoll maxRoll |
	
	(attackerRollsCollection isEmpty or: [defenderRollsCollection isEmpty]) ifTrue: [ ^Error signal: self emptyRollsErrorMessage ].
	"(attackerRollsCollection size > 3 or: [defenderRollsCollection size > 3]) ifTrue: [ ^Error signal: self tooManyDiceErrorMessage ]. Deberian estar aca tambien?"
	
	minRoll _ (attackerRollsCollection min) min: (defenderRollsCollection min).
	maxRoll _ (attackerRollsCollection max) max: (defenderRollsCollection max).
	
	(minRoll < 1 or: maxRoll > 6) ifTrue: [ ^Error signal: self invalidRollValueErrorMessage ]. 
	
	^self basicNew attackerRolls: attackerRollsCollection defenderRolls: defenderRollsCollection.! !

!InvasionDiceRoller class methodsFor: 'instance creation' stamp: 'FB 10/26/2017 16:27:25'!
new
	
	"Not used in tests. Allows simulating invasion with random dice rolls"
	
	^self basicNew attackerRolls: (OrderedCollection new) defenderRolls: (OrderedCollection new).! !
