//
//  SetCardMathingGame.m
//  Matchismo
//
//  Created by Qing Yang on 20/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
@interface SetCardMatchingGame ()

@end
@implementation SetCardMatchingGame

//- (NSMutableArray *) selectedCard
//{
//    if(!_selectedCard)
//    {
//        _selectedCard = [[NSMutableArray alloc] init];
//        
//    }
//    return _selectedCard;
//}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    SetCard * currentCard = (SetCard *)[self cardAtIndex:index];
    int tempScore = 0;
    if (!currentCard.isChosen) {
      
        if (currentCard) {
            if (!currentCard.isSelected) {
                [self.selectedCards removeObject:currentCard];
            }
            else{
                if ([self.selectedCards count] == 2) {
                    tempScore = [currentCard matchCard:self.selectedCards];
                    self.score += tempScore;
                    [self.selectedCards addObject:currentCard];
                    for (SetCard * card in self.selectedCards) {
                        if (tempScore > 0) {
                            card.chosen = YES;
                        }
                        card.isSelected = NO;
                    }


                    if ([self.delegate respondsToSelector:@selector(matchingResult:withScore:)]) {
                        [self.delegate matchingResult:self withScore:tempScore];
                    }
                    
                    [self.selectedCards removeAllObjects];
                }
                else
                {
                    [self.selectedCards addObject:currentCard];
                    tempScore = 0;
                }
            }
        }
    }
   
}

- (NSArray *)hintedCards
{
    NSMutableArray * cards = [[NSMutableArray alloc] initWithCapacity:3];
    for (NSUInteger i = 0; i < [self.cards count]; i++) {
        for (NSUInteger j = i+1; j < [self.cards count]; j++) {
            for (NSUInteger k = j+1; k < [self.cards count]; k++) {
                SetCard * firstCard = (SetCard *)[self cardAtIndex:i];
                SetCard * secondCard = (SetCard *)[self cardAtIndex:j];
                SetCard * thirdCard = (SetCard *)[self cardAtIndex:k];
                if ([firstCard matchCard:@[secondCard, thirdCard]] > 0) {
                    [cards addObject:firstCard];
                    [cards addObject:secondCard];
                    [cards addObject:thirdCard];
                    return [cards copy];
                }
            }
        }
    }
    return [cards copy];
}





@end
