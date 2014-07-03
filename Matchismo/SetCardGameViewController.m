//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Qing Yang on 20/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardFaceView.h"
#import "SetCard.h"
#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"
#import "Grid.h"
@interface SetCardGameViewController ()
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (strong, nonatomic) SetCardMatchingGame * setCardMatchingGame;
@property (strong, nonatomic) Deck * deck;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) Grid * grid;
@property (weak, nonatomic) IBOutlet UIScrollView *cardDeskScrollView;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (nonatomic) int cardNumber;
@end

#define CARD_NUMBER_INIT 12
@implementation SetCardGameViewController

- (NSMutableArray *)cardViews
{
    if (_cardViews == nil) {
        _cardViews = [[NSMutableArray alloc] init];
    }
    return _cardViews;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (SetCardDeck *)createDeck
{
    return [[SetCardDeck alloc] init];
}
- (IBAction)hi:(UIBarButtonItem *)sender {
    NSArray * hintsArray = [self.setCardMatchingGame hintedCards];
    if ([hintsArray count]) {
        for (Card * card in hintsArray) {
            SetCardFaceView * cardView = (SetCardFaceView *)[self.cardViews objectAtIndex:[self.setCardMatchingGame IndexOfCard:card]];
            cardView.highlighted = YES;
        }
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Errrr" message:@"None Set on Desk." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
}

- (SetCardMatchingGame* )setCardMatchingGame
{
    if (!_setCardMatchingGame) {
        _setCardMatchingGame = [[SetCardMatchingGame alloc] initWithCardCount:CARD_NUMBER_INIT usingDeck:self.deck mode:3];
        _setCardMatchingGame.delegate = self;
    }
    
    return _setCardMatchingGame;
}

- (void)matchingResult:(SetCardMatchingGame *)game withScore:(int)tempScore
{
    [self.resultView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect firstRect = CGRectMake(self.resultView.frame.origin.x, self.resultView.frame.origin.y, 30, 45);
    CGRect secondRect = CGRectMake(self.resultView.frame.origin.x+45, self.resultView.frame.origin.y, 30, 45);
    CGRect thirdRect = CGRectMake(self.resultView.frame.origin.x+90, self.resultView.frame.origin.y, 30, 45);
    
    CGRect firstResultRect = CGRectMake(0, 0, 30, 45);
    CGRect secondResultRect = CGRectMake(45, 0, 30, 45);
    CGRect thirdResultRect = CGRectMake(90, 0, 30, 45);
    
    if (tempScore > 0) {
        NSUInteger firstViewIndex = [game IndexOfCard:game.selectedCards[0]];
        SetCardFaceView * firstFace = [self.cardViews objectAtIndex:firstViewIndex];
        NSUInteger secondViewIndex = [game IndexOfCard:game.selectedCards[1]];
        SetCardFaceView * secondFace = [self.cardViews objectAtIndex:secondViewIndex];
        NSUInteger thirdViewIndex = [game IndexOfCard:game.selectedCards[2]];
        SetCardFaceView * thirdFace = [self.cardViews objectAtIndex:thirdViewIndex];
        CGRect firstNewRect = [self.cardDeskScrollView convertRect:firstFace.frame toView:self.view];
        [firstFace removeFromSuperview];
        firstFace.frame = firstNewRect;
        [self.view addSubview:firstFace];
        CGRect secondNewRect = [self.cardDeskScrollView convertRect:secondFace.frame toView:self.view];
        [secondFace removeFromSuperview];
        secondFace.frame = secondNewRect;
        [self.view addSubview:secondFace];
        CGRect thirdNewRect = [self.cardDeskScrollView convertRect:thirdFace.frame toView:self.view];
        [thirdFace removeFromSuperview];
        thirdFace.frame = thirdNewRect;
        [self.view addSubview:thirdFace];
        [UIView transitionWithView:firstFace
                          duration:0.5
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            firstFace.frame = firstRect;
                        }
                        completion:^(BOOL completed){
                            firstFace.frame = firstResultRect;
                            [firstFace removeFromSuperview];
                            [self.resultView addSubview:firstFace];
                            
                            
                        }];
        [UIView transitionWithView:secondFace
                          duration:0.5
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            secondFace.frame = secondRect;
                        }
                        completion:^(BOOL completed){
                            secondFace.frame = secondResultRect;
                            [secondFace removeFromSuperview];
                            [self.resultView addSubview:secondFace];
                            
                        }];
        [UIView transitionWithView:thirdFace
                          duration:0.5
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            thirdFace.frame = thirdRect;
                        }
                        completion:^(BOOL completed){
                            thirdFace.frame = thirdResultRect;
                            [thirdFace removeFromSuperview];
                            [self.resultView addSubview:thirdFace];
                            
                        }];
        [self.cardViews removeObject:firstFace];
        [self.cardViews removeObject:secondFace];
        [self.cardViews removeObject:thirdFace];
        for (SetCard * card in game.selectedCards) {
            if (![game replaceCard:card withDeck:self.deck]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"None card left in deck." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
                return;
            };
        }
        [self resetCardPositionInPositions:@[[NSNumber numberWithUnsignedInteger: firstViewIndex], [NSNumber numberWithUnsignedInteger: secondViewIndex], [NSNumber numberWithUnsignedInteger: thirdViewIndex]]];
        self.resultLabel.text = @"Matched!";
        self.collectionCountLabel.text = [NSString stringWithFormat:@"Collection: %ld",  (long)self.setCardMatchingGame.score];
    }
    else{
        SetCardFaceView * firstFace = [[SetCardFaceView alloc] initWithFrame:firstResultRect];
        firstFace.card = game.selectedCards[0];
        SetCardFaceView * secondFace = [[SetCardFaceView alloc] initWithFrame:secondResultRect];
        secondFace.card = game.selectedCards[1];
        SetCardFaceView * thirdFace = [[SetCardFaceView alloc] initWithFrame:thirdResultRect];
        thirdFace.card = game.selectedCards[2];
        [self.resultView addSubview:firstFace];
        [self.resultView addSubview:secondFace];
        [self.resultView addSubview:thirdFace];
        self.resultLabel.text = @"Not Matched!";
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self redealGame];
    }
    
}

- (IBAction)redeal:(UIButton *)sender {
    UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"Reset game?" message:@"Reset game?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Yes", nil];
    [view show];
    

}

- (void)redealGame
{
    _deck = nil;
    [self.cardDeskScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _setCardMatchingGame = [[SetCardMatchingGame alloc] initWithCardCount:CARD_NUMBER_INIT usingDeck:self.deck];
    self.cardNumber = CARD_NUMBER_INIT;
    [self setup];
}

- (void)selected:(SetCardFaceView *)cardView isSelected:(BOOL)isSelected
{
    [self.setCardMatchingGame chooseCardAtIndex:[self.cardViews indexOfObject:cardView]];
    [self UIUpdate];
    
    
}

- (IBAction)needMoreCards:(UIButton *)sender {
    if ([self.setCardMatchingGame moreCardOfNumber:3 withDeck:self.deck]) {
        
        for (uint i = self.cardNumber ; i <  self.cardNumber + 3; i++) {
            
            uint column = i % self.grid.columnCount;
            uint row = i / self.grid.columnCount;
            CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
            int random_x = arc4random() %5 * 2000 - 1000;
            int random_y = arc4random() %5 * 2000 - 1000;
            CGRect tempRect = CGRectMake(random_x, random_y, rect.size.width, rect.size.height);
            SetCardFaceView * cardView = [[SetCardFaceView alloc] initWithFrame: tempRect
                                          ];
            [self.cardDeskScrollView addSubview:cardView];
            SetCard * card = (SetCard *)[self.setCardMatchingGame cardAtIndex:i];
            cardView.card = card;
            cardView.delegate = self;
            [self.cardViews addObject:cardView];
            self.cardDeskScrollView.contentSize = CGSizeMake(self.cardDeskScrollView.frame.size.width, rect.origin.y + rect.size.height + 20);
            [UIView transitionWithView:cardView
                              duration:1
                               options:UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                cardView.frame = rect;
                            }
             
                            completion:^(BOOL completed){}];
            
            
        }
        self.cardNumber += 3;
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"None card left in deck." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
}

- (void)UIUpdate
{
    for (int i = 0 ; i < [self.cardViews count]; i ++) {
        SetCard * card = (SetCard*)[self.setCardMatchingGame cardAtIndex:i];
        ((SetCardFaceView *)self.cardViews[i]).card = card;
        ((SetCardFaceView *)self.cardViews[i]).delegate = self;
    }
}

- (void)resetCardPositionInPositions: (NSArray *) position
{
    for (uint i = 0 ; i <  self.cardNumber; i++) {
        if ([position containsObject:[NSNumber numberWithUnsignedInt:i] ]) {
            uint column = i % self.grid.columnCount;
            uint row = i / self.grid.columnCount;
            CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
            int random_x = arc4random() %5 * 2000 - 1000;
            int random_y = arc4random() %5 * 2000 - 1000;
            CGRect tempRect = CGRectMake(random_x, random_y, rect.size.width, rect.size.height);
            SetCardFaceView * cardView = [[SetCardFaceView alloc] initWithFrame: tempRect
                                          ];
            [self.cardDeskScrollView addSubview:cardView];
            SetCard * card = (SetCard *)[self.setCardMatchingGame cardAtIndex:i];
            cardView.card = card;
            cardView.delegate = self;
            [self.cardViews insertObject:cardView atIndex:i];
            [UIView transitionWithView:cardView
                              duration:1
                               options:UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                cardView.frame = rect;
                            }
             
                            completion:^(BOOL completed){}];
        }
        
        
        
    }
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.grid = [[Grid alloc] init];
    self.grid.size = self.cardDeskScrollView.frame.size;
    self.grid.cellAspectRatio = 2.0 / 3.0;
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait) {
        self.grid.minimumNumberOfCells = self.cardNumber;
        self.grid.minCellWidth = 45;
    }
    else{
        self.grid.minimumNumberOfCells = CARD_NUMBER_INIT;
        self.grid.maxCellWidth = 55;
    }
    for (uint i = 0 ; i < self.cardNumber; i++) {
        uint column = i % self.grid.columnCount;
        uint row = i / self.grid.columnCount;
        CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
        SetCardFaceView * cardView = self.cardViews[i];
        
        self.cardDeskScrollView.contentSize = CGSizeMake(self.cardDeskScrollView.frame.size.width, rect.origin.y + rect.size.height + 20);
        [UIView transitionWithView:cardView
                          duration:0.6
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            cardView.frame = rect;
                        }
         
                        completion:^(BOOL completed){}];
        
        
    }
}

- (void)setup
{
    self.grid = [[Grid alloc] init];
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait) {
        self.grid.minCellWidth = 45;
    }
    else{
        self.grid.maxCellWidth = 55;
    }
    self.grid.size = self.cardDeskScrollView.frame.size;
    self.grid.cellAspectRatio = 2.0 / 3.0;
    self.grid.minimumNumberOfCells =  self.cardNumber;
    
    
    for (uint i = 0 ; i <  self.cardNumber; i++) {
        uint column = i % self.grid.columnCount;
        uint row = i / self.grid.columnCount;
        CGRect rect = [self.grid frameOfCellAtRow: row inColumn:column];
        int random_x = arc4random() %5 * 2000 - 1000;
        int random_y = arc4random() %5 * 2000 - 1000;
        CGRect tempRect = CGRectMake(random_x, random_y, rect.size.width, rect.size.height);
        SetCardFaceView * cardView = [[SetCardFaceView alloc] initWithFrame: tempRect
                                      ];
        [self.cardDeskScrollView addSubview:cardView];
        SetCard * card = (SetCard *)[self.setCardMatchingGame cardAtIndex:i];
        cardView.card = card;
        cardView.delegate = self;
        [self.cardViews addObject:cardView];
        [UIView transitionWithView:cardView
                          duration:1
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
    // Do any additional setup after loading the view.
    self.cardNumber = CARD_NUMBER_INIT;
    
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_setCardMatchingGame) {
        [self setup];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
