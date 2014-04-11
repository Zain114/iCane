//
//  MDLTextViewDelegate.m
//  iCane
//
//  Created by Luffy on 3/19/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLTextViewDelegate.h"

@implementation MDLTextViewDelegate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return true;
}

@end
