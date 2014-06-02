//
//  ACDStoreKit.m
//  StoreKitExample
//
//  Created by Acid Studios on 01/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

#import "ACDStoreKit.h"

#import <StoreKit/StoreKit.h>
@interface ACDStoreKit(Private)
- (void) requestProducts;
- (void) createReceiptForTransaction:(SKPaymentTransaction *)transaction;
@end

@implementation ACDStoreKit
+ (instancetype) sharedStore {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) loadStore {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self requestProducts];
}

- (BOOL) canMakePayments {
    return [SKPaymentQueue canMakePayments];
}

- (void) purchaseItem:(SKProduct*)item {
    SKPayment *payment = [SKPayment paymentWithProduct:item];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - Private Methods
- (void) requestProducts {
    identifiers = [NSSet setWithArray:self.productIdentifiers];
    request = [[SKProductsRequest alloc] initWithProductIdentifiers:identifiers];
    request.delegate = self;
    [request start];
}

- (void) createReceiptForTransaction:(SKPaymentTransaction *)transaction {
    [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:transaction.payment.productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - SKProductsRequestDelegate
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if(self.productRequestSuccessBlock)
        self.productRequestSuccessBlock(response.products, response.invalidProductIdentifiers);
}

- (void) request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.productRequestFailBlock(error);
}


#pragma mark - SKPaymentTransactionObserver
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                self.productPaymentTransactionComplete(transaction);
                break;
            case SKPaymentTransactionStateRestored:
                self.productPaymentTransactionRestore(transaction);
                break;
            case SKPaymentTransactionStateFailed:
                self.productPaymentTransactionFailed(transaction);
                break;
        }
        
        if(transaction.transactionState != SKPaymentTransactionStateFailed && transaction.transactionState != SKPaymentTransactionStatePurchasing) {
            [self createReceiptForTransaction:transaction];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }
}


@end
