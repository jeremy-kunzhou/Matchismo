//
//  SetCard.h
//  Matchismo
//
//  Created by Qing Yang on 19/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) BOOL isSelected;

+ (NSArray *) numbers;
+ (NSArray *) symbols;
+ (NSArray *) shadings;
+ (NSArray *) colors;
@end

