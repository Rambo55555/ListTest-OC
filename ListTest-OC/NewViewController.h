//
//  NewView.h
//  ListTest-OC
//
//  Created by rambo on 2021/7/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol NeWViewControllerDelegate <NSObject>

@required

- (void)sendValue: (NSString *_Nullable) string;

@end

typedef void(^sendValueByBlock)(NSString* _Nullable str);

@interface NewViewController : UIViewController

@property (nonatomic, copy) sendValueByBlock _Nullable sendValueBlock;
@property (strong,nonatomic) NSString * _Nullable str;
@property (nonatomic, weak, nullable) id <NeWViewControllerDelegate> delegate;

- (void)returnSendValue:(sendValueByBlock _Nonnull )block;
@end

