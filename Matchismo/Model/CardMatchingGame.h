//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#define PENALTY_SCORE 2;
#define BONUS_SCORE 4;
#define COST_TO_CHOOSE 1;
@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck;
- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck mode:(NSUInteger)cardCompareNumber;
- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSUInteger)IndexOfCard:(Card *)card;
- (BOOL)replaceCard: (Card *) card withDeck: (Deck *)deck;
- (BOOL)moreCardOfNumber: (NSUInteger) count withDeck: (Deck *)deck;
@property (nonatomic) NSInteger score;
@property (nonatomic, readonly) NSString * information;
@property (nonatomic, strong) NSMutableArray * selectedCards;
//protected property
@property (nonatomic, strong) NSMutableArray * cards;
@end
