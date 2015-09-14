//
//  AnswerView.h
//  angelslike
//
//  Created by angelslike on 15/9/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

typedef enum{
    AnswerViewType_Cancel = 1,
    AnswerViewType_Comfrim = 2,
}AnswerViewType;

typedef void(^AnswerBlock)(id Obj,AnswerViewType asType);

@interface AnswerView : UIView{
    UIView *anView;
    UIButton *cancelButton;
    UIButton *comfirmButton;
    UITextView *textView;
    UILabel *title;
    id object;
}

@property(nonatomic,copy) AnswerBlock block;
-(void)showWithObject:(id)obj withTitle:(NSString *)msg;
-(void)show;
-(void)dismiss;

@end
