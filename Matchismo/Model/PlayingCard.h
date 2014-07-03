//
//  PlayingCard.h
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic, strong) NSString * suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;
@end
