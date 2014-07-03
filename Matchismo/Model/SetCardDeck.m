//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Qing Yang on 19/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        for (int i = 0 ; i < [[SetCard numbers] count]; i ++) {
            NSUInteger number = [((NSNumber *)[SetCard numbers][i]) unsignedIntegerValue];
            for (int j = 0 ; j < [[SetCard colors] count]; j ++) {
                NSUInteger color = [((NSNumber *)[SetCard colors][j]) unsignedIntegerValue];
                for (int k = 0 ; k < [[SetCard symbols] count]; k ++) {
                    NSUInteger symbol = [((NSNumber *)[SetCard symbols][k]) unsignedIntegerValue];
                    for (int l = 0 ; l < [[SetCard shadings] count]; l ++) {
                        NSUInteger shading = [((NSNumber *)[SetCard shadings][l]) unsignedIntegerValue];
                        SetCard * card = [[SetCard alloc]init];
                        card.number = number;
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.isSelected = NO;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
