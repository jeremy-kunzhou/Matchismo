//
//  SetCard.m
//  Matchismo
//
//  Created by Qing Yang on 19/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *) numbers
{
    NSArray * array = @[@1, @2, @3];
    return array;
}

+ (NSArray *) symbols
{
    NSArray * array = @[@1, @2, @3];
    return array;
}

+ (NSArray *) shadings
{
    NSArray * array = @[@1, @2, @3];
    return array;
}

+ (NSArray *) colors
{
    NSArray * array = @[@1, @2, @3];
    return array;
}

- (int)matchCard:(NSArray *)otherCards
{
    int result = 0;
    // numbers trail
    NSArray * numberArray = @[[NSNumber numberWithUnsignedInteger:self.number], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[0]).number], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[1]).number]];
    
    NSArray * symbolArray = @[[NSNumber numberWithUnsignedInteger:self.symbol], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[0]).symbol], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[1]).symbol]];

    NSArray * shadingArray = @[[NSNumber numberWithUnsignedInteger:self.shading], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[0]).shading], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[1]).shading]];

    NSArray * colorArray = @[[NSNumber numberWithUnsignedInteger:self.color], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[0]).color], [NSNumber numberWithUnsignedInteger:((SetCard *)otherCards[1]).color]];
    
    if ([self matched:numberArray] && [self matched:symbolArray] && [self matched:shadingArray] && [self matched:colorArray]) {
        result = 3;
    }
    
    return result;
}

- (BOOL) matched: (NSArray *)array
{
    BOOL result = NO;
    NSUInteger first = [((NSNumber *)array[0]) unsignedIntegerValue];
    NSUInteger second = [((NSNumber *)array[1]) unsignedIntegerValue];
    NSUInteger third = [((NSNumber *)array[2]) unsignedIntegerValue];
    if (first == second && second == third) {
        result = YES;
    }
    if (first != second && second != third && first != third) {
        result = YES;
    }
    
    return result;
}

@end

