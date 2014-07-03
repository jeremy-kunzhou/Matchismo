//
//  PlayingCard.m
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize  suit = _suit;
- (NSString *)contents
{
    NSArray * rankStrings = [PlayingCard rankStrings];
    return [NSString stringWithFormat:@"%@%@", rankStrings[self.rank], self.suit];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSArray *)validSuits
{
    return @[@"♠️",@"♣️",@"❤️",@"♦️"];
//    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject: suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1 ;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)matchSingleCard:(Card *)otherCard
{
    int score = 0;
    if ([otherCard isMemberOfClass:[PlayingCard class]]) {
        PlayingCard * otherPlayCard = (PlayingCard *)otherCard;
        if ([otherPlayCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherPlayCard.rank == self.rank)
        {
            score = 4;
        }
    }
    
    return score;
}

- (int)matchCard:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] >= 1) {
        for (NSUInteger i = 0; i < [otherCards count]; i ++)
        {
            if ([otherCards[i] isMemberOfClass:[PlayingCard class]]) {
                PlayingCard * card = otherCards[i];
                score += [self matchSingleCard:card];
                for (NSUInteger j = i + 1; j < [otherCards count]; j ++)
                {
                     if ([otherCards[j] isMemberOfClass:[PlayingCard class]]) {
                         score += [card matchSingleCard:otherCards[j]];
                     }
                }
            }
           
        
        }
       
    }
   
    
    return score;
}

- (NSString *)description
{
    return [self contents];
    
}

@end
