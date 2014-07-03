//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"
@interface CardGameViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray * cardsViews;
@property (strong, nonatomic) Deck * deck;

@end
