//
//  SetCardFaceView.h
//  Matchismo
//
//  Created by Qing Yang on 19/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"
@protocol SetCardFaceViewDelegate;

@interface SetCardFaceView : UIView
@property (nonatomic, strong) SetCard * card;
@property (nonatomic) id <SetCardFaceViewDelegate> delegate;
@property (nonatomic) BOOL highlighted;
@end

@protocol SetCardFaceViewDelegate <NSObject>

-(void)selected: (SetCardFaceView *) cardView isSelected: (BOOL) isSelected;

@end
