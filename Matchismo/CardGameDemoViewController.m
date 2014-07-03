//
//  CardGameDemoViewController.m
//  Matchismo
//
//  Created by Qing Yang on 10/05/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "CardGameDemoViewController.h"
#import "SetCardFaceView.h"
#import "SetCard.h"
@interface CardGameDemoViewController ()

@end

@implementation CardGameDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect tempRect = CGRectMake(40, 40, 200, 300);
    SetCardFaceView * cardView = [[SetCardFaceView alloc] initWithFrame: tempRect
                                  ];
    [self.view addSubview:cardView];
    SetCard * card = [[SetCard alloc] init];
    card.number = 3;
    card.shading = 1;
    card.color = 1;
    card.symbol = 3;
    cardView.card = card;

    
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
