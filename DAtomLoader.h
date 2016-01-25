//
//  DAtomLoader.h
//  
//
//  Created by Divyanshu Sharma on 25/01/16.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DAtomLoader : NSObject

@property(strong,nonatomic) UIImage *centerImage;

+(DAtomLoader *)sharedInstance;

-(void)setCenterImage:(UIImage *)yourImage;

// Method for Atom View Animation
-(void)starAnimation:(UIView *)superView;
-(void)stopAnimation:(UIView *)superView;
@end
