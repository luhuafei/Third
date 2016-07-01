//
//  YFPatchModel.h
//  iOS122
//
//  Created by 颜风 on 15/11/12.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YFPatchModel : MTLModel<YFPatchModel>
@property (copy, nonatomic) NSString * patchId; //!< 补丁id.用于唯一标记一个补丁.因为补丁,后期可能需要更新,删除,添加等操作.
@property (copy, nonatomic) NSString * md5; //!< 文件的md5值,用于校验.
@property (copy, nonatomic) NSString * url; //!< 文件的URL路径.
@property (copy, nonatomic) NSString * ver; //!< 补丁对应的APP版本.不需要服务器返回,但需要本地存储此值.这个值在涉及到多个版本的补丁共存时,在应用升级时会很有价值.
@property (assign, nonatomic) YFPatchModelStatus status; //!< 补丁状态.此状态值由本地管理和维护.

@end
