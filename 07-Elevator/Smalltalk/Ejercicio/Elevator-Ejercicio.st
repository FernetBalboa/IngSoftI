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


!ElevatorTest methodsFor: 'tests 1' stamp: 'FB 10/2/2017 18:26:48'!
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

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:50:00'!
isClosed

	^true.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:50:05'!
isClosing

	^false.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:50:10'!
isOpened

	^false.! !

!CabinDoorClosedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:50:15'!
isOpening

	^false.! !


!classDefinition: #CabinDoorClosingState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:26'!
isClosed

	^false.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:31'!
isClosing

	^true.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:40'!
isOpened

	^false.! !

!CabinDoorClosingState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:45'!
isOpening

	^false.! !


!classDefinition: #CabinDoorOpenedState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpenedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:48:57'!
isClosed

	^false.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:04'!
isClosing

	^false.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:13'!
isOpened

	^true.! !

!CabinDoorOpenedState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:49:18'!
isOpening

	^false.! !


!classDefinition: #CabinDoorOpeningState category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpeningState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:48:46'!
isClosed

	^false.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:48:40'!
isClosing

	^false.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:46:32'!
isOpened

	^false.! !

!CabinDoorOpeningState methodsFor: 'cabin door status' stamp: 'FB 10/2/2017 18:46:27'!
isOpening

	^true.! !


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

!CabinMovingState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 18:51:32'!
isMoving

	^true.! !

!CabinMovingState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 18:51:36'!
isStopped

	^false.! !


!classDefinition: #CabinStoppedState category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStoppedState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 18:51:41'!
isMoving

	^false.! !

!CabinStoppedState methodsFor: 'cabin status' stamp: 'FB 10/2/2017 18:53:42'!
isStopped

	^true.! !


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


!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 19:04:19'!
cabinDoorClosed

	cabinDoorState _ CabinDoorClosedState new.
	cabinState _ CabinMovingState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 21:21:19'!
cabinDoorClosing

	(state isIdle or: cabinState isMoving) ifFalse: [cabinDoorState _ CabinDoorClosingState new].! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 19:30:42'!
cabinDoorOpened

	cabinDoorState _ CabinDoorOpenedState new.
	floorsToGo isEmpty ifTrue: [ state _ ElevatorIdleState new.]! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:05:43'!
cabinDoorOpening

	cabinDoorState _ CabinDoorOpeningState new.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 16:20:20'!
closeCabinDoor

	"Stop waiting for people"
	self cabinDoorClosing.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/2/2017 19:28:14'!
openCabinDoor

	(cabinDoorState isOpened or: cabinState isMoving) 
		ifFalse: [cabinDoorState _ CabinDoorOpeningState new].
	! !


!ElevatorController methodsFor: 'cabin floor' stamp: 'FB 10/2/2017 15:57:20'!
cabinFloorNumber

	^cabinFloorNumber.! !

!ElevatorController methodsFor: 'cabin floor' stamp: 'FB 10/2/2017 20:53:16'!
cabinOnFloor: aFloorNumber

	cabinFloorNumber _ aFloorNumber.
	"(aFloorNumber = floorsToGo first) ifTrue: self cabinStop cabinDoorOpening."
	self cabinStop.
	self  openCabinDoor.
	state waitingForPeople: true.
	floorsToGo  remove: aFloorNumber.
! !

!ElevatorController methodsFor: 'cabin floor' stamp: 'FB 10/2/2017 21:00:10'!
goUpPushedFromFloor: aFloorNumber
 
	floorsToGo add: aFloorNumber.
	state _ ElevatorWorkingState for: state isWaitingForPeople.
	cabinDoorState  _ CabinDoorClosingState new.! !


!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 16:04:48'!
cabinStop

	cabinState _ CabinStoppedState new.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:53:14'!
isCabinMoving

	^cabinState isMoving.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 15:53:27'!
isCabinStopped

	^cabinState isStopped.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 20:55:02'!
isCabinWaitingForPeople
	^state isWaitingForPeople.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/2/2017 21:03:25'!
waitForPeopleTimedOut
	state waitingForPeople: false.
	cabinDoorState _ CabinDoorClosingState new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'instance creation' stamp: 'FB 10/2/2017 20:47:57'!
new

	^(self basicNew initializeWithElevatorState: ElevatorIdleState new cabinState: CabinStoppedState new cabinDoorState: CabinDoorOpenedState new cabinFloorNumber: 0 floorsToGo: SortedCollection new).
	
	! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:30:32'!
isIdle

	self subclassResponsibility.! !

!ElevatorState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 19:54:49'!
isWaitingForPeople

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

!ElevatorIdleState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:59'!
isIdle
	
	^true.! !

!ElevatorIdleState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 19:53:22'!
isWaitingForPeople

	^false ! !

!ElevatorIdleState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:53'!
isWorking
	
	^false.! !


!classDefinition: #ElevatorWorkingState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorWorkingState
	instanceVariableNames: 'waitingForPeople'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:46'!
isIdle

	^false.! !

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 19:48:30'!
isWaitingForPeople

	^ waitingForPeople.! !

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:41'!
isWorking

	^true.! !


!ElevatorWorkingState methodsFor: 'initialize' stamp: 'FB 10/2/2017 20:48:47'!
initialize

	waitingForPeople _ false. ! !

!ElevatorWorkingState methodsFor: 'initialize' stamp: 'FB 10/2/2017 21:01:23'!
initialize: aBoolean

	waitingForPeople _ aBoolean. ! !

!ElevatorWorkingState methodsFor: 'initialize' stamp: 'FB 10/2/2017 20:53:06'!
waitingForPeople: aBoolean

	waitingForPeople _ aBoolean.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorWorkingState class' category: #'Elevator-Ejercicio'!
ElevatorWorkingState class
	instanceVariableNames: ''!

!ElevatorWorkingState class methodsFor: 'instance creation' stamp: 'FB 10/2/2017 21:00:43'!
for: aBoolean

	^self basicNew initialize: aBoolean.! !

!ElevatorWorkingState class methodsFor: 'instance creation' stamp: 'FB 10/2/2017 21:00:56'!
new

	^self for: false.! !
