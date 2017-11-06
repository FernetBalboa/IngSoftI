!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/30/2017 19:03:09'!
item1SoldByStore
	^ 'Item 1 sold by store'.! !

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/30/2017 19:03:15'!
item2SoldByStore
	^ 'Item 2 sold by store'.! !

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/26/2017 21:43:18'!
itemNotSoldByStore

	^'Item not sold by store'.! !


!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/26/2017 21:23:33'!
test01NewCartIsEmpty

	| cart |
	
	cart _ self createCart.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 10:54:30'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart _ self createCart.
	
	self
		should: [ cart add: self itemNotSoldByStore]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty.].
		! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 10:57:45'!
test03CartIsNotEmptyAfterAddingAnItem
	| cart |
	cart _ self createCart.
	cart add: self item1SoldByStore.
	self assert: cart isEmpty not.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:00:04'!
test04CartCanHaveMoreThanOneElement

	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	cart add: item2.
		
	self assert: cart isEmpty not.
	self assert: (cart includes: item1).
	self assert: (cart includes: item2).! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:02:32'!
test05CartCanAddSameItemMoreThanOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 2.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:04:34'!
test06CartCanAddManyOfTheSameItemAtOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: 4 of: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 5.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:13:53'!
test07RemovingAUnitOfAnItemDecreasesItsOcurrencesByOne
	
	| cart item1 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	
	cart add: item1.
	cart add: item1.
	cart remove: item1.
	
	self
		assert: (cart occurrencesOf: item1)
		equals: 1.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:13:59'!
test08CartDoesNotIncludeItemAfterRemovingAllItsOcurrences
	
	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	cart add: item1.
	cart add: item1.
	cart add: item2.
	cart remove: item1.
	cart remove: item1.
	cart remove: item1.
	
	self assert: (cart includes: item1) not.
	self assert: (cart includes: item2).! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:14:04'!
test09CanNotRemoveAnItemFromCartThatWasNotAdded

	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	
	self
		should: [ cart remove: item2. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart itemNotInCartErrorMessage.
			self assert: (cart includes: item1).
			self assert: (cart includes: item2) not ].

	! !


!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 19:04:05'!
createCart
	^ Cart withCatalogue: self defaultCatalogue.! !

!TusLibrosTest methodsFor: 'cart creation' stamp: 'CM 11/6/2017 16:43:41'!
createSalePage

	^ OrderedCollection new.! !

!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 21:02:50'!
createSalesBook

	^ Dictionary new.! !

!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 18:19:25'!
defaultCatalogue
	
	| catalogue |
	catalogue _ Dictionary new.
	catalogue at: (self item1SoldByStore) put: 10 * peso.
	catalogue at: (self item2SoldByStore) put: 30 * peso.
	^catalogue.
	! !


!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:48:06'!
test10CanNotCreateCreditCardWithEmptyName
	
	| register |
	
	register _ self createCreditCardsRegister.
	
	self
		should: [ register add: self createCreditCardWithEmptyName ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard emptyOwnerNameErrorMessage.
			self assert: register isEmpty ].! !

!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:49:02'!
test11CreditCardNumberMustHave16Digits
	"Esto solo testea que no falla con 15 digitos. Seria bueno testear que tampoco funcione con 17, asi cubrimos los casos borde"
	
	| register |
	
	register _ self createCreditCardsRegister.
	
	self
		should: [ register add: self createCreditCardWithInvalidNumber ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberErrorMessage.
			self assert: register isEmpty ].! !

!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:50:19'!
test12ExpiredCreditCardKnowsItHasExpired
	"Buscar mejor nombre para el test"
	| card register |
	
	register _ self createCreditCardsRegister.
	card _ self createExpiredCreditCard.
	
	register add: card.
	
	self assert: (card isExpiredAtDate: Date today).
	self assert: (register includes: card).! !


!TusLibrosTest methodsFor: 'cashier creation' stamp: 'CM 11/2/2017 16:18:33'!
createCashier

	^Cashier with: self createCart with: self createMPSimulator.! !


!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:30:38'!
createCreditCardWithEmptyName
	
	"Preguntar si contamos los espacios en blanco como caracteres"
	"Este metodo no corresponde aca, deberia moverse a la interfaz mas adelante"
	
	^CreditCard withOwner: ' ' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:28:55'!
createCreditCardWithInvalidName
	
	"Preguntar si contamos los espacios en blanco como caracteres"
	"Este metodo no corresponde aca, deberia moverse a la interfaz mas adelante"
	
	^CreditCard withOwner: 'Name is too long to put in card' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 12:48:52'!
createCreditCardWithInvalidNumber

	^CreditCard withOwner: 'Juan Perez' withNumber: '540000000000000' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:46:59'!
createCreditCardsRegister

	^OrderedCollection new.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:27:54'!
createExpiredCreditCard
	
	| lastMonth |
	
	lastMonth _ Date today month previous.
	
	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: lastMonth.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'CM 11/2/2017 16:32:47'!
createStolenCreditCard

	^CreditCard withOwner: 'arsene lupin' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:19:12'!
createValidCreditCard

	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !


!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:43:55'!
test13CanNotCheckoutEmptyCart
	| cashier card salesBook |
	cashier _ self createCashier.
	card _ self createValidCreditCard.
	salesBook _ self createSalePage .
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:44:03'!
test14CanNotCheckoutCartWithExpiredCreditCard
	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createExpiredCreditCard.
	salesBook _ self createSalePage.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:44:10'!
test15CashierCalculatesTheRightAmountToDebit
	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	cart add: self item1SoldByStore.
	cart add: self item2SoldByStore.
	cart add: self item2SoldByStore.
	card _ self createValidCreditCard.
	salesBook _ self createSalePage.
		
	self assert: (cashier checkoutWithCreditCard: card registerOn: salesBook) = (80 * peso).! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:44:17'!
test16CanNotCheckoutWithStolenCreditCard

	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createStolenCreditCard.
	cashier merchantProcessor simulateUsing: [self stolenCreditCardException ].
	salesBook _ self createSalePage.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator stolenCreditCardMessage ].
	self assert: salesBook isEmpty.	! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:44:23'!
test17CanNotCheckoutWithInsufficientFunds

	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createStolenCreditCard.
	cashier merchantProcessor simulateUsing: [self insufficientFundsCreditCardException].
	salesBook _ self createSalePage.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator insufficentFundsMessage ].
	self assert: salesBook isEmpty.	! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'CM 11/6/2017 16:44:30'!
test18CanNotCheckoutWithInvalidCreditCard

	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createValidCreditCard. "Valida como tarjeta, no existente en la BD del MP"
	cashier merchantProcessor simulateUsing: [self invalidCreditCardException].
	salesBook _ self createSalePage.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator invalidCreditCardMessage ].
	self assert: salesBook isEmpty.	! !


!TusLibrosTest methodsFor: 'MP creation' stamp: 'CM 11/2/2017 16:20:15'!
createMPSimulator

	^ MerchantProcessorSimulator with: [true]! !


!TusLibrosTest methodsFor: 'Merchant Processor Simulator Exceptions' stamp: 'CM 11/2/2017 17:31:15'!
insufficientFundsCreditCardException

	^Error signal: MerchantProcessorSimulator insufficentFundsMessage 
	! !

!TusLibrosTest methodsFor: 'Merchant Processor Simulator Exceptions' stamp: 'CM 11/2/2017 17:47:19'!
invalidCreditCardException

	^Error signal: MerchantProcessorSimulator invalidCreditCardMessage 
	! !

!TusLibrosTest methodsFor: 'Merchant Processor Simulator Exceptions' stamp: 'CM 11/2/2017 17:31:26'!
stolenCreditCardException

	^Error signal: MerchantProcessorSimulator stolenCreditCardMessage 
	! !


!TusLibrosTest methodsFor: 'User Creation' stamp: 'CM 11/6/2017 15:56:25'!
createUserRegistry
	| user userRegistry |

	userRegistry _ OrderedCollection new.
	user _ self createValidUser.
	userRegistry add: user.

	^userRegistry ! !

!TusLibrosTest methodsFor: 'User Creation' stamp: 'FB 11/2/2017 19:59:57'!
createUserWithInvalidID

	^User id: 'BadID'  password: 'BuenoMuyBuenoPassword' ! !

!TusLibrosTest methodsFor: 'User Creation' stamp: 'FB 11/2/2017 20:00:39'!
createUserWithInvalidPassword.
	
	^User id: 'GoodID'  password: 'PasswordMaloMaloso' ! !

!TusLibrosTest methodsFor: 'User Creation' stamp: 'FB 11/2/2017 20:47:07'!
createValidUser
	
	^User id: 'user'  password: 'password' ! !


!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:21:58'!
test19CanNotCreateCartForInvalidUser
	| interface invalidIdUser invalidPasswordUser |
	interface _ self defaultInterface.
	invalidIdUser _ self createUserWithInvalidID.
	invalidPasswordUser _ self createUserWithInvalidPassword.
	self
		should: [ interface createCartForAUser: invalidIdUser ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SystemInterface invalidUserErrorMessage ].
	self
		should: [ interface createCartForAUser: invalidPasswordUser ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SystemInterface invalidUserErrorMessage ].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 14:20:50'!
test20CanCreateCartForValidUser
	| interface user|
	interface _ self defaultInterface. 
	user _ self createValidUser .
	
	self shouldnt: [interface createCartForAUser: user] raise: Error ! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 14:00:52'!
test21CanAddItemsToCart
	| interface idCart user item|
	interface _ self defaultInterface. 
	user _ self createValidUser .
	item _ self item1SoldByStore. 
	idCart _ interface createCartForAUser: user.
	interface add: 1 of: item to: idCart .
	
	self assert: ( (interface listCart: idCart) includes: item ).! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:21:58'!
test22CannotAddItemsToInvalidCart
	| interface idCart item |
	interface _ self defaultInterface.
	item _ self item1SoldByStore.
	idCart _ 1.
	self
		should: [
			interface
				add: 1
				of: item
				to: idCart ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SystemInterface invalidCartErrorMessage ].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 14:14:04'!
test23CannotAddNotExistingItems
	|user itemNotSold interface idCart |
	interface _ self defaultInterface. 
	
	itemNotSold _ self itemNotSoldByStore .
	
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	
	self
		should: [ interface add: 1 of: itemNotSold to: idCart ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: (interface listCart: idCart) isEmpty.].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 14:16:29'!
test24ListCartOfANewCartIsEmpty
	| interface idCart user|
	interface _ self defaultInterface. 
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	
	self assert: (interface listCart: idCart) isEmpty.! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 14:40:53'!
test25ListCartHasTheCorrectNumberOfOccurrences
	|item1 item2 cartBag interface idCart user|
	interface _ self defaultInterface. 
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	
	item1 _ self item1SoldByStore. 
	item2 _ self item2SoldByStore.
	interface add: 2 of: item1 to: idCart .
	interface add: 3 of: item2 to: idCart .
	
	cartBag _ interface listCart: idCart.
	
	self assert: ((cartBag occurrencesOf: item1) = 2).
	self assert: ((cartBag occurrencesOf: item2) = 3).! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:14:12'!
test26CannotCheckOutAnEmptyCart
	| interface idCart user card |
	interface _ self defaultInterface. 
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	card _ self createValidCreditCard .
	
	self
		should: [ interface checkOutCart: idCart withCreditCard: card ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText =  Cashier emptyCartCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:21:58'!
test27CannotCheckOutAnNotExistingCart
	| interface wrongId idCart user card |
	interface _ self defaultInterface.
	user _ self createValidUser.
	idCart _ interface createCartForAUser: user.
	card _ self createValidCreditCard.
	wrongId _ 10.
	self
		should: [
			interface
				checkOutCart: wrongId
				withCreditCard: card ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SystemInterface invalidCartErrorMessage ].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:19:37'!
test28CannotCheckOutWithAInvalidCard
	| interface idCart user card item |
	interface _ self defaultInterface. 
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	item _ self item1SoldByStore .
	interface add: 1 of: item to: idCart. 
	card _ self createExpiredCreditCard .
	
	self
		should: [ interface checkOutCart: idCart withCreditCard: card ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText =  Cashier expiredCardCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 15:21:33'!
test29CanCheckOut
	| interface idCart user card item |
	interface _ self defaultInterface. 
	user _ self createValidUser .
	idCart _ interface createCartForAUser: user.
	item _ self item1SoldByStore .
	interface add: 1 of: item to: idCart. 
	card _ self createValidCreditCard .
	
	self shouldnt: [ interface checkOutCart: idCart withCreditCard: card ] raise: Error ! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 16:16:46'!
test30CannotListPurchasesOfAnInvalidUser
	| interface userWrongPassword userWrongId |
	interface _ self defaultInterface. 
	userWrongPassword _ self createUserWithInvalidPassword.
	userWrongId _ self createUserWithInvalidID.
	self
		should: [ interface listPurchases: userWrongPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText =  SystemInterface invalidUserErrorMessage ].
		
	self
		should: [ interface listPurchases: userWrongId ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText =  SystemInterface invalidUserErrorMessage ].	! !

!TusLibrosTest methodsFor: 'Interface test' stamp: 'CM 11/6/2017 17:23:13'!
test31ListPurchasesReturnsTheCorrectData
	| interface idCart user item1 item2 card list sale1 sale2 |
	card _ self createValidCreditCard .
	interface _ self defaultInterface. 
	user _ self createValidUser .
	
	item1 _ self item1SoldByStore. 
	item2 _ self item2SoldByStore. 
	
	sale1 _ Sale of: item1 times: 2  each: (10*peso).
	sale2 _ Sale of: item2 times: 2  each: (30*peso).
	
	idCart _ interface createCartForAUser: user.
	interface add: 2 of: item1 to: idCart .
	interface add: 2 of: item2 to: idCart .
	interface checkOutCart: idCart withCreditCard: card.
	
	list _ interface listPurchases: user.
	
	self assert: ( list includesKey: (80*peso) ).
	self assert: ( (list at: (80*peso)) includes: sale1 ).
	self assert: ( (list at: (80*peso)) includes: sale2 ).! !


!TusLibrosTest methodsFor: 'interface creation' stamp: 'CM 11/6/2017 15:21:58'!
defaultInterface
	^ SystemInterface
		withUsers: self createUserRegistry
		products: self defaultCatalogue
		recordingOn: self createSalesBook
		debitingThrought: self createMPSimulator.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'FB 10/27/2017 10:35:46'!
initializeWithCatalogue: aCatalogue

	items _ Bag new.
	catalogue _ aCatalogue.! !


!Cart methodsFor: 'adding items' stamp: 'FB 10/30/2017 18:21:19'!
add: anItem
	
	(catalogue includesKey: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
	items add: anItem.
	! !

!Cart methodsFor: 'adding items' stamp: 'FB 10/30/2017 18:21:42'!
add: quantity of: anItem
	
	(catalogue includesKey: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
	items add: anItem withOccurrences: quantity.
	! !


!Cart methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:57:22'!
catalogue

	^catalogue.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/27/2017 10:36:46'!
includes: anItem

	^items includes: anItem.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/26/2017 19:59:10'!
isEmpty

	^items isEmpty.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/30/2017 18:27:22'!
items

	^items.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/27/2017 11:01:38'!
occurrencesOf: anItem

	^items occurrencesOf: anItem.! !


!Cart methodsFor: 'removing items' stamp: 'FB 10/27/2017 11:13:42'!
remove: anItem
	
	"Implementacion desactualizada. Dejar para mas adelante, no esta en la especificacion"
	
	items remove: anItem ifAbsent: [^Error signal: self class itemNotInCartErrorMessage ].! !


!Cart methodsFor: 'errors' stamp: 'FB 10/26/2017 21:35:58'!
invalidItemErrorMessage

	^Error signal: (self class invalidItemErrorMessage).! !

!Cart methodsFor: 'errors' stamp: 'FB 10/26/2017 21:37:11'!
itemNotInCartErrorMessage
	^ Error signal: self class itemNotInCartErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'FB 10/26/2017 21:36:30'!
invalidItemErrorMessage

	^'Error: invalid item'.! !

!Cart class methodsFor: 'error messages' stamp: 'FB 10/26/2017 21:36:38'!
itemNotInCartErrorMessage

	^'Error: item not in cart'.! !


!Cart class methodsFor: 'instance creation' stamp: 'FB 10/27/2017 10:52:20'!
withCatalogue: aCatalogue
	^ self basicNew initializeWithCatalogue: aCatalogue.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart catalogue merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'CM 11/2/2017 16:50:46'!
checkoutWithCreditCard: aCreditCard registerOn: aSalesBook 

	| totalAmount |
	cart isEmpty ifTrue: [ ^Error signal: self class emptyCartCheckoutErrorMessage. ].
	(aCreditCard isExpiredAtDate: Date today) ifTrue: [ ^Error signal: self class expiredCardCheckoutErrorMessage. ].
	
	totalAmount _ cart items inject: 0 * peso into: 
		[ :subTotal :anItem | subTotal + (catalogue at: anItem)].
	merchantProcessor debit: totalAmount from: aCreditCard.
	self recordSaleOn: aSalesBook. 
	
	^totalAmount.
	! !

!Cashier methodsFor: 'checkout' stamp: 'CM 11/6/2017 17:23:39'!
recordSaleOn: aSalesBook
	|sale|
	
	(cart items asSet) do: [:anItem |
		sale _ Sale of: anItem times: (cart occurrencesOf: anItem) each: (catalogue at: anItem).   
		 aSalesBook add: sale. ]! !


!Cashier methodsFor: 'initialization' stamp: 'CM 11/2/2017 16:22:35'!
initializeWith: aShoppingCart with: aMerchantProcessor

	cart _ aShoppingCart.
	catalogue _ cart catalogue.
	merchantProcessor _ aMerchantProcessor .! !


!Cashier methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:59:30'!
cart

	^cart.! !

!Cashier methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:59:45'!
catalogue

	^catalogue.! !

!Cashier methodsFor: 'inspection' stamp: 'CM 11/2/2017 16:17:38'!
merchantProcessor

	^merchantProcessor ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!


!Cashier class methodsFor: 'instance creation' stamp: 'CM 11/2/2017 16:21:43'!
with: aShoppingCart with: aMerchantProcessor

	^self basicNew initializeWith: aShoppingCart with: aMerchantProcessor .! !


!Cashier class methodsFor: 'error messages' stamp: 'FB 10/27/2017 11:27:39'!
emptyCartCheckoutErrorMessage

	^'Error: can not checkout empty cart'.! !

!Cashier class methodsFor: 'error messages' stamp: 'FB 10/28/2017 13:30:38'!
expiredCardCheckoutErrorMessage
	
	^'Error: can not checkout with expired credit card'.! !



!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonthAndYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FB 10/28/2017 14:14:53'!
initializeWithOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear
	
	owner _ anOwnerName.
	number _ aCreditCardNumber.
	expirationMonthAndYear _ anExpirationMonthAndYear.! !


!CreditCard methodsFor: 'status' stamp: 'FB 10/31/2017 09:26:07'!
isExpiredAtDate: aDate
	
	^expirationMonthAndYear start < aDate month start.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FB 10/31/2017 09:43:51'!
withOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear
	
	| letters |
	
	letters _ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	
	(anOwnerName includesAnyOf: letters) ifFalse: [ ^Error signal: self emptyOwnerNameErrorMessage ].
	aCreditCardNumber size ~= 16 ifTrue: [ ^Error signal: self invalidNumberErrorMessage ].
	
	^self basicNew initializeWithOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/31/2017 09:32:15'!
emptyOwnerNameErrorMessage

	^'Error: credit card owner name can not be empty'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/28/2017 12:42:54'!
invalidNumberErrorMessage

	^'Error: credit card number must have 16 digits'.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialize' stamp: 'CM 11/2/2017 16:09:56'!
initializeWith: aClousure

	value  _ aClousure ! !


!MerchantProcessorSimulator methodsFor: 'set' stamp: 'CM 11/2/2017 16:25:15'!
simulateUsing: aClousure

	value  _ aClousure ! !


!MerchantProcessorSimulator methodsFor: 'process' stamp: 'CM 11/2/2017 16:24:28'!
debit: aAmount from: aCreditCard

	^ value value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'CM 11/2/2017 17:25:43'!
insufficentFundsMessage

	^'Insufficent Funds'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'CM 11/2/2017 17:40:08'!
invalidCreditCardMessage

	^'Invalid Credit Card'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'CM 11/2/2017 17:24:42'!
stolenCreditCardMessage

	^'Stolen Credit Card'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'CM 11/2/2017 16:11:00'!
with: aClosure

	^ self new initializeWith: aClosure .! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'item count value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'CM 11/6/2017 17:23:26'!
initializeOf: anItem times: aQuantity each: anAmount

	item  _ anItem .
	count _ aQuantity .
	value _ anAmount * aQuantity .! !


!Sale methodsFor: 'inspect' stamp: 'CM 11/6/2017 17:25:50'!
= otherSale

	^ ( (item = otherSale item) and: (count = otherSale count) ) and: ( value = otherSale value )! !

!Sale methodsFor: 'inspect' stamp: 'CM 11/6/2017 17:26:06'!
count

	^count ! !

!Sale methodsFor: 'inspect' stamp: 'CM 11/6/2017 17:26:15'!
item

	^item ! !

!Sale methodsFor: 'inspect' stamp: 'CM 11/6/2017 17:10:03'!
value

	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'CM 11/6/2017 16:46:03'!
of: anItem times: aQuantity each: anAmount

	^self basicNew initializeOf: anItem times: aQuantity each: anAmount ! !


!classDefinition: #SystemInterface category: #TusLibros!
Object subclass: #SystemInterface
	instanceVariableNames: 'registeredUsers catalogue merchantProcessor carts lastID salesBook usersById'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemInterface methodsFor: 'public actions' stamp: 'CM 11/6/2017 13:56:18'!
add: aQuantity of: anItem to: aCartID
	|cart|
	cart _ self cartWithID: aCartID. 	
	cart add: aQuantity of: anItem 
	
	! !

!SystemInterface methodsFor: 'public actions' stamp: 'CM 11/6/2017 16:55:43'!
checkOutCart: aCartId withCreditCard: aCreditCard
	|cashier user salePage cart|
	cart _ self cartWithID: aCartId.
	cashier _ Cashier with: cart with: merchantProcessor.
	user _ usersById at: aCartId.
	salePage _ self salesOfUser: user.
	cashier checkoutWithCreditCard: aCreditCard  registerOn: salePage.! !

!SystemInterface methodsFor: 'public actions' stamp: 'CM 11/6/2017 16:09:11'!
createCartForAUser: aUser
	|cart idCart|
	self assertIsARegisteredUser: aUser.
	
	cart _ Cart withCatalogue: catalogue.
	idCart _ lastID. 
	carts at: lastID put: cart.
	usersById at: lastID put: aUser.
	salesBook at: aUser ifAbsent: [ salesBook at: aUser put: (OrderedCollection new) ].
	lastID _ idCart + 1.
	
	^idCart 
	
		
	
	! !

!SystemInterface methodsFor: 'public actions' stamp: 'CM 11/6/2017 13:56:54'!
listCart: aCart

	^( (self cartWithID: aCart ) items ) copy. ! !

!SystemInterface methodsFor: 'public actions' stamp: 'CM 11/6/2017 17:12:36'!
listPurchases: aUser 
	|total list userSales|
	self assertIsARegisteredUser: aUser .
	total  _ (self salesOfUser: aUser) inject: 0 * peso into: 
		[ :subTotal :anItem | subTotal + (anItem value)].
	
	list _ Dictionary new.
	userSales _ (self salesOfUser: aUser) copy.
	list at: total put: userSales.
	
	^list 
		
		
	
	! !


!SystemInterface methodsFor: 'private' stamp: 'CM 11/6/2017 15:56:47'!
assertIsARegisteredUser: aUser.

	(registeredUsers includes: aUser) ifFalse: [self invalidUserError]  
	
	
	
	! !

!SystemInterface methodsFor: 'private' stamp: 'CM 11/6/2017 14:04:04'!
cartWithID: aCartID

	^carts at: aCartID ifAbsent: [self invalidCartIdError]! !

!SystemInterface methodsFor: 'private' stamp: 'CM 11/6/2017 16:04:10'!
salesOfUser: anUser

	^salesBook at: anUser ! !


!SystemInterface methodsFor: 'initialization' stamp: 'CM 11/6/2017 15:58:39'!
initializeWithUsers: aUserRegistry products: aCatalogue recordingOn: aSalesBook debitingThrought: aMerchantProcessor 
	
	registeredUsers _ aUserRegistry .
	catalogue _	aCatalogue.
	salesBook _ aSalesBook .
	merchantProcessor _ aMerchantProcessor .
	lastID _ 0.
	carts _ Dictionary new.	
	usersById _ Dictionary new.! !


!SystemInterface methodsFor: 'errors' stamp: 'CM 11/6/2017 15:21:58'!
invalidCartIdError
	^ Error signal: SystemInterface invalidCartErrorMessage.! !

!SystemInterface methodsFor: 'errors' stamp: 'CM 11/6/2017 15:21:58'!
invalidUserError
	^ Error signal: SystemInterface invalidUserErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemInterface class' category: #TusLibros!
SystemInterface class
	instanceVariableNames: 'aValidUsers'!

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'CM 11/6/2017 14:03:46'!
invalidCartErrorMessage
	
	^ 'Invalid Cart'! !

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'FB 11/2/2017 20:16:10'!
invalidUserErrorMessage
	
	^ 'Invalid User'! !

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'CM 11/6/2017 13:36:10'!
withUsers: aUserRegistry products: aCatalogue recordingOn: aSalesBook debitingThrought: aMerchantProcessor 

	^self basicNew initializeWithUsers: aUserRegistry products: aCatalogue recordingOn: aSalesBook debitingThrought: aMerchantProcessor 
! !


!classDefinition: #User category: #TusLibros!
Object subclass: #User
	instanceVariableNames: 'id pword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!User methodsFor: 'inspect' stamp: 'CM 11/6/2017 15:46:58'!
= otherUser

	^ (id = otherUser id) and: (pword = otherUser password)! !

!User methodsFor: 'inspect' stamp: 'FB 11/2/2017 19:54:00'!
id

	^id ! !

!User methodsFor: 'inspect' stamp: 'CM 11/6/2017 13:50:16'!
password

	^pword ! !


!User methodsFor: 'initialization' stamp: 'FB 11/2/2017 19:57:28'!
intializeWithID: anId andPassword: aPassword 

	id _ anId.
	password _ aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'User class' category: #TusLibros!
User class
	instanceVariableNames: ''!

!User class methodsFor: 'as yet unclassified' stamp: 'FB 11/2/2017 19:57:55'!
id: anId password: aPassword

	^self basicNew intializeWithID: anId andPassword: aPassword 
	! !
