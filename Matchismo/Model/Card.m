//
//  Card.m
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) matchCard:(NSArray *) otherCards
{
    int score = 0;
    
    for (Card * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
   
    
    return score;
}

@end
