//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Qing Yang on 4/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "Grid.h"
#define CARD_NUMBER 15

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame * cardMatchingGame;
@property (nonatomic) NSUInteger gameMode;
@property (nonatomic, strong) Grid * grid;
@property (weak, nonatomic) IBOutlet UIView *cardsDeskView;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@end

@implementation CardGameViewController


- (NSMutableArray *)cardsViews
{
    if (!_cardsViews) {
        _cardsViews = [[NSMutableArray alloc] init];
    }
    return _cardsViews;
}

- (IBAction)redealButtonClicked:(UIButton *)sender {
    UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"Reset game?" message:@"Reset game?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Yes", nil];
    [view show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self redealGame];
    }
    
}

- (void)redealGame
{
    _deck = nil;
    [self.cardsDeskView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _cardMatchingGame = [[CardMatchingGame alloc] initWithCardCount:CARD_NUMBER usingDeck:self.deck mode:self.gameMode];
    [self setup];
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (CardMatchingGame *) cardMatchingGame
{
    if (!_cardMatchingGame) {
        _cardMatchingGame = [[CardMatchingGame alloc] initWithCardCount:CARD_NUMBER usingDeck:self.deck mode:self.gameMode];
    }
    return _cardMatchingGame;
}


- (void)UIUpdate
{
    for (PlayingCardView * cardView in self.cardsDeskView.subviews) {
        Card * card = [self.cardMatchingGame cardAtIndex:[self.cardsDeskView.subviews indexOfObject:cardView]];
        if (!card.isMatched) {
            if (cardView.faceUp != card.isChosen) {
                [UIView transitionWithView:cardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    cardView.faceUp =  card.isChosen;
                                }
                                completion:^(BOOL completed){}];
                
            }
            
        }
        else{
            cardView.faceUp = true;
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.cardMatchingGame.score];
    self.historyLabel.text = self.cardMatchingGame.information;
}

- (NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundForCard: (Card *) card
{
    return [UIImage imageNamed:card.isChosen? @"Cardfront":@"Cardback"];
}

- (void)tapCard:(UITapGestureRecognizer *) gesture
{
    
    PlayingCardView * cardView = (PlayingCardView *)gesture.view;
    Card * card = [self.cardMatchingGame cardAtIndex:[self.cardsDeskView.subviews indexOfObject:cardView]];
    if (!card.isMatched) {
        [self.cardMatchingGame chooseCardAtIndex:[self.cardsDeskView.subviews indexOfObject:cardView]];
    }
    [UIView transitionWithView:cardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self UIUpdate];
                    }
                    completion:^(BOOL completed){}];
}


- (void)setup
{

    for (uint i = 0 ; i < CARD_NUMBER; i++) {
        uint column = i % self.grid.columnCount;
        uint row = i / self.grid.columnCount;
        CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
        int random_x = arc4random() %5 * 2000 - 1000;
        int random_y = arc4random() %5 * 2000 - 1000;
        CGRect tempRect = CGRectMake(random_x, random_y, rect.size.width, rect.size.height);
        PlayingCardView * cardView = [[PlayingCardView alloc] initWithFrame: tempRect
                                      ];
        [self.cardsDeskView addSubview:cardView];
        PlayingCard * card = (PlayingCard *)[self.cardMatchingGame cardAtIndex:i];
        cardView.rank = card.rank;
        cardView.suit = card.suit;
        cardView.faceUp = card.chosen;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
        [cardView addGestureRecognizer:tap];
        [UIView transitionWithView:cardView
                          duration:1
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            cardView.frame = rect;
                        }
         
                        completion:^(BOOL completed){}];
        
        
    }
    
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.grid = [[Grid alloc] init];
    self.grid.size = self.cardsDeskView.bounds.size;
    self.grid.cellAspectRatio = 2.0 / 3.0;
    self.grid.minimumNumberOfCells = CARD_NUMBER;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait) {
        self.grid.minCellWidth = 45;
    }
    else{
        self.grid.maxCellWidth = 50;
    }
    for (uint i = 0 ; i < CARD_NUMBER; i++) {
        uint column = i % self.grid.columnCount;
        uint row = i / self.grid.columnCount;
        CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
        PlayingCardView * cardView = self.cardsDeskView.subviews[i];
        
        
        [UIView transitionWithView:cardView
                          duration:0.6
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            cardView.frame = rect;
                        }
         
                        completion:^(BOOL completed){}];
        
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gameMode = 2;


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!_cardMatchingGame)
    {
        self.grid = [[Grid alloc] init];
        self.grid.size = self.cardsDeskView.bounds.size;
        self.grid.cellAspectRatio = 2.0 / 3.0;
        self.grid.minimumNumberOfCells = CARD_NUMBER;
        self.grid.minCellWidth = 45;
        [self setup];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
