//
//  SetCardMathingGame.h
//  Matchismo
//
//  Created by Qing Yang on 20/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "CardMatchingGame.h"

@protocol SetCardMatchingGameDelegate;

@interface SetCardMatchingGame : CardMatchingGame
//@property (nonatomic, strong) NSMutableArray * selectedCard;
@property (nonatomic, weak) id <SetCardMatchingGameDelegate> delegate;
- (NSArray *)hintedCards;
@end

@protocol SetCardMatchingGameDelegate <NSObject>

- (void)matchingResult: (SetCardMatchingGame *)game withScore: (int)tempScore;


@end
