//
//  YFCustomPhotoAlbumViewController.m
//  iOS122
//
//  Created by 颜风 on 15/12/1.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFCustomPhotoAlbumViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@implementation YFCustomPhotoAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    
    NSURL * url = [NSURL URLWithString: @"https://o05kg8tfy.qnssl.com/wp-content/uploads/2016/06/54fbb2fb43166.jpg?imageView2/1/w/755/h/400"];
    [manager downloadImageWithURL: url options: 0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%g", receivedSize * 1.0 / expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (nil != error) {
            NSLog(@"%@", error);
            
            return;
        }
        
        NSString * key = [manager cacheKeyForURL: imageURL];
        
        /* 存相册前,要先清一下内存缓存,否则会导致内存无法释放.[缓存机制和相册写入机制的内部冲突,源码不可见,真实原因未知] */
        [manager.imageCache removeImageForKey:key fromDisk: NO withCompletion:^{
            ALAssetsLibrary * library = [[ALAssetsLibrary alloc] init];
            
            [library saveImage:image toAlbum:@"iOS1" withCompletionBlock:^(NSURL *assetUrl, NSError *error) {
                NSLog(@"%@ %@", assetUrl, error);
            }];
        }];
        
    }];
}
@end
