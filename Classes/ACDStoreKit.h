//
//  ACDStoreKit.h
//  StoreKitExample
//
//  Created by Acid Studios on 01/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^ACDStoreKitProductRequestSuccessBlock)(NSArray *products, NSArray *invalidProducts);
typedef void (^ACDStoreKitProductRequestSuccessFail)(NSError *error);
typedef void (^ACDStoreKitProductPaymentTransactionComplete)(SKPaymentTransaction *transaction);
typedef void (^ACDStoreKitProductPaymentTransactionFailed)(SKPaymentTransaction *transaction);
typedef void (^ACDStoreKitProductPaymentTransactionRestore)(SKPaymentTransaction *transaction);

@interface ACDStoreKit : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    NSSet *identifiers;
    SKProductsRequest *request;
}

@property (nonatomic, copy) ACDStoreKitProductRequestSuccessBlock productRequestSuccessBlock;
@property (nonatomic, copy) ACDStoreKitProductRequestSuccessFail productRequestFailBlock;
@property (nonatomic, copy) ACDStoreKitProductPaymentTransactionComplete productPaymentTransactionComplete;
@property (nonatomic, copy) ACDStoreKitProductPaymentTransactionFailed productPaymentTransactionFailed;
@property (nonatomic, copy) ACDStoreKitProductPaymentTransactionRestore productPaymentTransactionRestore;

@property (nonatomic) NSArray *productIdentifiers;

+ (instancetype) sharedStore;

/**
 *  Load the In-App Purchases
 */
- (void) loadStore;

/**
 *  Validate if the user can make payments
 *
 *  @return YES Can make Payments, NO The user disable In-App Puchases.
 */
- (BOOL) canMakePayments;

/**
 *  Purchase Item
 *
 *  @param item SKProduct - Product to be purchased.
 */
- (void) purchaseItem:(SKProduct*)item;
@end
