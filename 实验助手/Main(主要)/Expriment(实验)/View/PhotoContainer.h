// //  PhotoContainer.h
//  Photo
//
//  Created by SXQ on 15/10/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellContainerViewModel;

@interface PhotoContainer : UIView
@property (nonatomic,strong) NSMutableArray *myImages;
@property (nonatomic,strong) CellContainerViewModel *viewModel;
+ (CGSize)photosViewSizeWithPhotosCount:(NSUInteger)count;
@end

