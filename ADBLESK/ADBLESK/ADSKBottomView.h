//
//  ADSKBottomView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSKBottomView : UIView

@property (nonatomic,weak) IBOutlet UIImageView *foodTypeImageView;
@property (nonatomic,weak) IBOutlet UILabel *foodNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *cookDegreeLabel;

@property (nonatomic,weak) IBOutlet UIImageView *targetImageView;
@property (nonatomic,weak) IBOutlet UILabel *targetLabel;
@property (nonatomic,weak) IBOutlet UILabel *taggetTemLabel;

@property (nonatomic,weak) IBOutlet UILabel *grillTemLabel;

@property (nonatomic,assign)BOOL isGrillTemLightModel;

- (void)setfoodImageStr:(NSString *)imageStr foodType:(NSString *)foodTypeStr cookDegreeStr:(NSString *)cookDegreeStr;
- (void)setTagTemLabelText:(NSString *)tagTem;
- (void)setGrillTemLabelText:(NSString *)grillTem;

- (void)startGrillTemHighlightModel;
- (void)stopGrillTemHighlightModel;

@end
