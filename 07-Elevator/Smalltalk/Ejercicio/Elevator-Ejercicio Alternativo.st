!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorCabinEmergency category: #'Elevator-Ejercicio'!
ElevatorEmergency subclass: #ElevatorCabinEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorCabinEmergency class' category: #'Elevator-Ejercicio'!
ElevatorCabinEmergency class
	instanceVariableNames: ''!

!ElevatorCabinEmergency class methodsFor: 'error description' stamp: 'FB 10/10/2017 10:02:21'!
messageText

	^'Sensor de cabina desincronizado'.! !


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


!classDefinition: #Cabin category: #'Elevator-Ejercicio'!
Object subclass: #Cabin
	instanceVariableNames: 'state cabinDoor currentFloor waitingForPeople nextFloorToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Cabin methodsFor: 'initialization' stamp: 'FB 10/5/2017 15:19:41'!
initialize

	state _ CabinStoppedState new.
	cabinDoor _ CabinDoor new.
	waitingForPeople _ true.
	nextFloorToGo _ nil.
	currentFloor _ 0.! !


!Cabin methodsFor: 'cabin control' stamp: 'FB 10/10/2017 09:50:05'!
cabinOnFloor: aFloorNumber
	
	state cabin: self onFloor: aFloorNumber.
	! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 16:49:51'!
cabinWhenMovingOnFloor: aFloorNumber
	
	currentFloor _ aFloorNumber.
	nextFloorToGo = currentFloor ifTrue: [ state _ CabinStoppedState new. cabinDoor open ].
	! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 17:25:40'!
cabinWhenStoppedOnFloor: aFloorNumber
	
	^ElevatorCabinEmergency signal.
	! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 16:25:03'!
goUpPushedFromFloor: aFloorNumber
	nextFloorToGo _ aFloorNumber.
	self moveToNextFloorToGo.! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 16:25:03'!
moveToNextFloorToGo
	nextFloorToGo = nil ifFalse: cabinDoor close.! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 13:55:40'!
nextFloorToGo: aFloorNumber

	nextFloorToGo _ aFloorNumber.! !

!Cabin methodsFor: 'cabin control' stamp: 'FB 10/5/2017 16:25:03'!
waitForPeopleTimedOut
	waitingForPeople _ false.
	self moveToNextFloorToGo.! !


!Cabin methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:27:17'!
currentFloor

	^currentFloor.! !

!Cabin methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:46:59'!
isMoving

	^state isMoving! !

!Cabin methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:47:06'!
isStopped

	^state isStopped! !

!Cabin methodsFor: 'cabin status' stamp: 'FB 10/5/2017 15:49:59'!
isWaitingForPeople

	^waitingForPeople.! !


!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:32:21'!
closeDoor
	
	state closeDoorFor: self.! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:24:00'!
closeDoorWhenMoving

	"Do nothing. Should already be closed."! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:23:06'!
closeDoorWhenStopped

	cabinDoor close.! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:35:02'!
doorClosed

	cabinDoor closed.
	state _ CabinMovingState new.! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:29:39'!
doorOpened

	cabinDoor opened.
	(nextFloorToGo = nil) ifFalse: [ waitingForPeople _ true ]! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:21:44'!
openDoor

	state openDoorFor: self.! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:24:21'!
openDoorWhenMoving

	"Do nothing. Shouldn't open door while cabin is moving."! !

!Cabin methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:23:39'!
openDoorWhenStopped

	cabinDoor open.! !


!Cabin methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 14:25:47'!
isDoorClosed

	^cabinDoor isClosed.! !

!Cabin methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 14:26:17'!
isDoorClosing

	^cabinDoor isClosing.! !

!Cabin methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 14:26:35'!
isDoorOpened

	^cabinDoor isOpened.! !

!Cabin methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 14:26:29'!
isDoorOpening

	^cabinDoor isOpening.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cabin class' category: #'Elevator-Ejercicio'!
Cabin class
	instanceVariableNames: ''!

!Cabin class methodsFor: 'instance creation' stamp: 'FB 10/5/2017 15:20:08'!
new
	
	^self basicNew initialize.! !


!classDefinition: #CabinDoor category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoor
	instanceVariableNames: 'state doorMotor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoor methodsFor: 'initialization' stamp: 'FB 10/5/2017 13:18:56'!
initialize

	state _ CabinDoorOpenedState new.
	doorMotor _ CabinDoorMotor new.! !


!CabinDoor methodsFor: 'door status' stamp: 'FB 10/5/2017 14:28:52'!
isClosed

	^state isClosed.! !

!CabinDoor methodsFor: 'door status' stamp: 'FB 10/5/2017 14:28:57'!
isClosing

	^state isClosing.! !

!CabinDoor methodsFor: 'door status' stamp: 'FB 10/5/2017 14:28:38'!
isOpened

	^state isOpened.! !

!CabinDoor methodsFor: 'door status' stamp: 'FB 10/5/2017 14:28:44'!
isOpening

	^state isOpening.! !


!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 16:38:44'!
close

	state closeDoor: self.! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:08:48'!
closeDoorWhenClosedOrClosing

	"Do nothing. Door already closed or being closed"! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 16:39:45'!
closeDoorWhenOpened

	doorMotor turnCounterClockwise.
	state _ CabinDoorClosingState new.! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 16:41:13'!
closeDoorWhenOpening

	"Closing the door does nothing when opening to wait for people."! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 14:36:51'!
closed

	doorMotor stop.
	state _ CabinDoorClosedState new.! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:39:48'!
open

	state openDoor: self.! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:08:09'!
openDoorWhenClosedOrClosing

	doorMotor turnClockwise.
	state _ CabinDoorOpeningState new.! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:13:16'!
openDoorWhenOpenedOrOpening

	"Do nothing. Door already opened or opening"! !

!CabinDoor methodsFor: 'door control' stamp: 'FB 10/5/2017 14:36:37'!
opened

	doorMotor stop.
	state _ CabinDoorOpenedState new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinDoor class' category: #'Elevator-Ejercicio'!
CabinDoor class
	instanceVariableNames: ''!

!CabinDoor class methodsFor: 'instance creation' stamp: 'FB 10/5/2017 15:20:56'!
new

	^self basicNew initialize.! !


!classDefinition: #CabinDoorMotor category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorMotor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorMotor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:33:14'!
stop

	"Stop motor"! !

!CabinDoorMotor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:32:09'!
turnClockwise

	"turn clockwise"! !

!CabinDoorMotor methodsFor: 'door control' stamp: 'FB 10/5/2017 15:32:46'!
turnCounterClockwise

	"turn counterclockwise"! !


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


!CabinDoorState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:40:59'!
closeDoor: aCabinDoor! !

!CabinDoorState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:40:53'!
openDoor: aCabinDoor! !


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


!CabinDoorClosedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:34:49'!
closeDoor: aCabinDoor

	aCabinDoor closeDoorWhenClosedOrClosing.! !

!CabinDoorClosedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:34:55'!
openDoor: aCabinDoor

	aCabinDoor openDoorWhenClosedOrClosing.! !


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


!CabinDoorClosingState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:36:31'!
closeDoor: aCabinDoor

	aCabinDoor closeDoorWhenClosedOrClosing.! !

!CabinDoorClosingState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:36:36'!
openDoor: aCabinDoor

	aCabinDoor openDoorWhenClosedOrClosing.! !


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


!CabinDoorOpenedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:40:38'!
closeDoor: aCabinDoor

	aCabinDoor closeDoorWhenOpened.! !

!CabinDoorOpenedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:36:54'!
openDoor: aCabinDoor

	aCabinDoor openDoorWhenOpenedOrOpening.! !


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


!CabinDoorOpeningState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:40:29'!
closeDoor: aCabinDoor

	aCabinDoor closeDoorWhenOpening.! !

!CabinDoorOpeningState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 15:37:01'!
openDoor: aCabinDoor

	aCabinDoor openDoorWhenOpenedOrOpening.! !


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


!CabinMovingState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:21:08'!
closeDoorFor: aCabin

	aCabin closeDoorWhenMoving.! !

!CabinMovingState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:21:00'!
openDoorFor: aCabin

	aCabin openDoorWhenMoving.! !


!CabinMovingState methodsFor: 'cabin control' stamp: 'FB 10/10/2017 09:49:22'!
cabin: aCabin onFloor: aFloorNumber

	aCabin cabinWhenMovingOnFloor: aFloorNumber.! !


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


!CabinStoppedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:21:27'!
closeDoorFor: aCabin

	aCabin closeDoorWhenStopped.! !

!CabinStoppedState methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:21:17'!
openDoorFor: aCabin

	aCabin openDoorWhenStopped.! !


!CabinStoppedState methodsFor: 'cabin control' stamp: 'FB 10/10/2017 09:49:44'!
cabin: aCabin onFloor: aFloorNumber

	aCabin cabinWhenStoppedOnFloor: aFloorNumber.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabin floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'initialization' stamp: 'FB 10/5/2017 13:22:58'!
initialize

	state _ ElevatorIdleState new.
	cabin  _ Cabin new.
	floorsToGo _ SortedCollection new.
	! !


!ElevatorController methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:51:09'!
isIdle

	^state isIdle.! !

!ElevatorController methodsFor: 'elevator status' stamp: 'FB 10/2/2017 15:51:19'!
isWorking

	^state isWorking.! !


!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 13:45:36'!
isCabinDoorClosed

	^cabin isDoorClosed.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 13:45:46'!
isCabinDoorClosing

	^cabin isDoorClosing.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 13:45:53'!
isCabinDoorOpened

	^cabin isDoorOpened.! !

!ElevatorController methodsFor: 'cabin door status' stamp: 'FB 10/5/2017 13:46:00'!
isCabinDoorOpening

	^cabin isDoorOpening.! !


!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 13:39:59'!
cabinDoorClosed

	cabin doorClosed.! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 14:06:42'!
cabinDoorOpened

	cabin doorOpened.
	floorsToGo isEmpty ifTrue: [ state _ ElevatorIdleState new. cabin nextFloorToGo: nil].! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:03:15'!
closeCabinDoor

	state closeCabinDoorOf: self! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:02:48'!
closeCabinDoorWhenWorking

	cabin closeDoor.
	! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:03:10'!
openCabinDoor

	state openCabinDoorOf: self.
	! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:02:33'!
openCabinDoorWhenWorking

	cabin openDoor.
	! !

!ElevatorController methodsFor: 'cabin door control' stamp: 'FB 10/5/2017 16:02:00'!
openOrCloseCabinDoorWhenIdle

	"Do nothing, elevator is idle."
	! !


!ElevatorController methodsFor: 'cabin control' stamp: 'FB 10/5/2017 15:49:00'!
cabinOnFloor: aFloorNumber

	cabin cabinOnFloor: aFloorNumber.
	floorsToGo  remove: aFloorNumber.
	floorsToGo isEmpty ifTrue: [ cabin nextFloorToGo: nil ] ifFalse: [ cabin nextFloorToGo: floorsToGo first ].
! !

!ElevatorController methodsFor: 'cabin control' stamp: 'FB 10/5/2017 13:59:56'!
goUpPushedFromFloor: aFloorNumber
 
	floorsToGo add: aFloorNumber.
	state _ ElevatorWorkingState new.
	cabin goUpPushedFromFloor: floorsToGo first.! !

!ElevatorController methodsFor: 'cabin control' stamp: 'FB 10/5/2017 15:57:19'!
waitForPeopleTimedOut
	
	cabin waitForPeopleTimedOut.! !

!ElevatorController methodsFor: 'cabin control' stamp: 'FB 10/5/2017 15:52:19'!
waitingForPeopleTimedOut
	
	^0.! !


!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:26:45'!
cabinFloorNumber

	^cabin currentFloor.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:25:00'!
isCabinMoving

	^cabin isMoving.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/5/2017 13:25:04'!
isCabinStopped

	^cabin isStopped.! !

!ElevatorController methodsFor: 'cabin status' stamp: 'FB 10/5/2017 15:50:25'!
isCabinWaitingForPeople

	^cabin isWaitingForPeople.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'instance creation' stamp: 'FB 10/5/2017 13:22:12'!
new

	^self basicNew initialize.
	
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


!ElevatorState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:06:18'!
closeCabinDoorOf: anElevatorController

	self subclassResponsibility.! !

!ElevatorState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:04:52'!
openCabinDoorOf: anElevatorController

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


!ElevatorIdleState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:07:32'!
closeCabinDoorOf: anElevatorController

	anElevatorController openOrCloseCabinDoorWhenIdle.! !

!ElevatorIdleState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:07:04'!
openCabinDoorOf: anElevatorController

	anElevatorController openOrCloseCabinDoorWhenIdle.! !


!classDefinition: #ElevatorWorkingState category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorWorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:46'!
isIdle

	^false.! !

!ElevatorWorkingState methodsFor: 'elevator status' stamp: 'FB 10/2/2017 18:50:41'!
isWorking

	^true.! !


!ElevatorWorkingState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:06:31'!
closeCabinDoorOf: anElevatorController

	anElevatorController closeCabinDoorWhenWorking.! !

!ElevatorWorkingState methodsFor: 'elevator control' stamp: 'FB 10/5/2017 16:05:48'!
openCabinDoorOf: anElevatorController

	anElevatorController openCabinDoorWhenWorking.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorWorkingState class' category: #'Elevator-Ejercicio'!
ElevatorWorkingState class
	instanceVariableNames: ''!

!ElevatorWorkingState class methodsFor: 'instance creation' stamp: 'FB 10/5/2017 13:31:13'!
new

	^self basicNew.! !
