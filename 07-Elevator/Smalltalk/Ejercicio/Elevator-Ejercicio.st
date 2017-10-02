!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #CabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:35:47'!
isClosed

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:35:44'!
isClosing

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:35:50'!
isOpened

	self subclassResponsibility.! !

!CabinDoorState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:35:38'!
isOpening

	self subclassResponsibility.! !


!classDefinition: #CabinDoorClosedState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:39:48'!
isClosed

	^True.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:39:43'!
isClosing

	^False.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:39:33'!
isOpened

	^False.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:39:40'!
isOpening

	^False.! !


!classDefinition: #CabinDoorClosingState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:50'!
isClosed

	^False.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:55'!
isClosing

	^True.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:43'!
isOpened

	^False.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:46'!
isOpening

	^False.! !


!classDefinition: #CabinDoorOpenedState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpenedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:17'!
isClosed

	^False.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:04'!
isClosing

	^False.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:27'!
isOpened

	^True.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:38:08'!
isOpening

	^False.! !


!classDefinition: #CabinDoorOpeningState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpeningState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:37:28'!
isClosed

	^False.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:37:30'!
isClosing

	^False.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:37:22'!
isOpened

	^False.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:37:37'!
isOpening

	^True.! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:34:01'!
isMoving

	self subclassResponsibility.! !

!CabinState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:33:55'!
isStopped

	self subclassResponsibility.! !


!classDefinition: #CabinMovingState category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinMovingState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:34:21'!
isMoving

	^True.! !

!CabinMovingState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:34:29'!
isStopped

	^False.! !


!classDefinition: #CabinStoppedState category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStoppedState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:34:58'!
isMoving

	^False.! !

!CabinStoppedState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:34:51'!
isStopped

	^True.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'initialization' stamp: 'FB 10/2/2017 15:43:53'!
initializeWithElevatorState: anElevatorState cabinState: aCabinState cabinDoorState: aCabinDoorState cabinFloorNumber: aFloorNumber floorsToGo: aQueueOfFloors

	state _ anElevatorState.
	cabinState  _ aCabinState.
	cabinDoorState _ aCabinDoorState.
	cabinFloorNumber _ aFloorNumber.
	floorsToGo _ aQueueOfFloors.
	! !


!ElevatorController methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:51:09'!
isIdle

	^state isIdle.! !

!ElevatorController methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:51:19'!
isWorking

	^state isWorking.! !


!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:53:50'!
isCabinDoorClosed

	^cabinDoorState isClosed.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:53:57'!
isCabinDoorClosing

	^cabinDoorState isClosing.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:52:51'!
isCabinDoorOpened

	^cabinDoorState isOpened.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 15:53:39'!
isCabinDoorOpening

	^cabinDoorState isOpening.! !


!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 15:59:48'!
cabinDoorClosed

	cabinDoorState _ CabinDoorClosedState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:05:59'!
cabinDoorClosing

	cabinDoorState _ CabinDoorClosingState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:06:12'!
cabinDoorOpened

	cabinDoorState _ CabinDoorOpenedState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:05:43'!
cabinDoorOpening

	cabinDoorState _ CabinDoorOpeningState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:20:20'!
closeCabinDoor

	"Stop waiting for people"
	self cabinDoorClosing.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:16:03'!
openCabinDoor

	self isStopped ifTrue: self cabinDoorOpening.! !


!ElevatorController methodsFor: 'cabin floor' stamp: 'FB 10/2/2017 15:57:20'!
cabinFloorNumber

	^cabinFloorNumber.! !

!ElevatorController methodsFor: 'cabin floor' stamp: 'FB 10/2/2017 16:04:06'!
cabinOnFloor: aFloorNumber

	cabinFloorNumber _ aFloorNumber.
	(aFloorNumber = floorsToGo first) ifTrue: self cabinStop cabinDoorOpening.! !


!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 16:04:48'!
cabinStop

	cabinState _ CabinStoppedState new.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:53:14'!
isCabinMoving

	^cabinState isMoving.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:53:27'!
isCabinStopped

	^cabinState isStopped.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'instance creation' stamp: 'FB 10/2/2017 15:45:28'!
new

	^self new initializeWithElevatorState: ElevatorIdleState cabinState: CabinStoppedState cabinDoorState: CabinDoorOpenedState cabinFloorNumber: 0 floorsToGo: OrderedCollection new.! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:30:32'!
isIdle

	self subclassResponsibility.! !

!ElevatorState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:31:03'!
isWorking

	self subclassResponsibility.! !


!classDefinition: #ElevatorIdleState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorIdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorIdleState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:32:07'!
isIdle
	
	^True.! !

!ElevatorIdleState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:31:56'!
isWorking
	
	^False.! !


!classDefinition: #ElevatorWorkingState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorWorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:32:23'!
isIdle

	^False.! !

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:31:30'!
isWorking

	^True.! !
