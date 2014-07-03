//
//  Deck.m
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (nonatomic, strong) NSMutableArray * cards;

@end

@implementation Deck


- (NSMutableArray * )cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}


- (void)addCard: (Card *)card
{
    [self addCard:card atTop:NO];
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
        
    }else {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard
{
    Card * randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % ([self.cards count]);
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
        
    }
    
    return randomCard;
}
@end
