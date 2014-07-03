//
//  Deck.h
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;
@interface Deck : NSObject

- (void)addCard: (Card *) card;
- (void)addCard: (Card *) card atTop: (BOOL)atTop;

- (Card *)drawRandomCard;
@end
