//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSString * information;


@property (nonatomic, readwrite) NSUInteger cardCompareNumber;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (NSMutableArray *)selectedCards
{
    if (!_selectedCards) {
        _selectedCards = [[NSMutableArray alloc] init];
    }
    return _selectedCards;
    
    
}

- (NSUInteger)IndexOfCard:(Card *)card
{
    return [self.cards indexOfObject:card];
}

- (BOOL)replaceCard: (Card *) card withDeck: (Deck *)deck
{
    Card * newCard = [deck drawRandomCard];
    if (newCard) {
        self.cards[[self.cards indexOfObject:card]] = newCard;
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (BOOL)moreCardOfNumber: (NSUInteger) count withDeck: (Deck *)deck
{
    BOOL result = NO;
    for (NSUInteger i = count; i > 0; i --) {
        Card * card = [deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
            result = YES;
        }
        else
        {
            result = NO;
        }
        
    }
    return  result;
}

- (NSUInteger)cardsCount
{
    return [self.cards count];
}

- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck mode:(NSUInteger)cardCompareNumber
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i ++) {
            Card * card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
        self.cardCompareNumber = cardCompareNumber;
        self.information = @"";
    }
    
    return self;
    
    
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    return [self initWithCardCount:count usingDeck:deck mode:2];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card * card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.selectedCards removeObject:card];
        } else {
            [self.selectedCards addObject:card];
            card.chosen = YES;
            if ([self.selectedCards count] == self.cardCompareNumber) {
                int matchScore = [self.selectedCards[0] matchCard:[self.selectedCards subarrayWithRange:NSMakeRange(1, self.cardCompareNumber -1)]];
                int currentScore = 0;
                if (matchScore) {
                    currentScore +=  (self.cardCompareNumber - 1) * matchScore * BONUS_SCORE;
                    for (Card * card in self.selectedCards) {
                        
                        card.matched = YES;

                    }
                    self.information = [NSString stringWithFormat:@"Matched %@ for %d points.", [self.selectedCards componentsJoinedByString:@" "], currentScore];
                    
                } else {
                    currentScore -= (self.cardCompareNumber - 1) * PENALTY_SCORE;
                   
                    
                    self.information = [NSString stringWithFormat:@"%@ don't match! %d points penalty!", [self.selectedCards componentsJoinedByString:@" "], currentScore];

                }
                self.score += currentScore;

               
            }
            else if([self.selectedCards count] == self.cardCompareNumber + 1)
            {
                [self.selectedCards removeLastObject];
                for (Card * card in self.selectedCards) {
                    
                    card.chosen = NO;
                    
                    
                }
                [self.selectedCards removeAllObjects];
                [self.selectedCards addObject:card];
//                self.score -= COST_TO_CHOOSE;
                self.information = [self.selectedCards componentsJoinedByString:@" "];
                

            }
            else
            {
                self.score -= COST_TO_CHOOSE;
                self.information = [self.selectedCards componentsJoinedByString:@" "];
                
            }
        }
        
    }
}

@end
