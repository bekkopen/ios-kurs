#import <Foundation/Foundation.h>

@protocol KURLConnectionDelegate <NSObject>
@required
- (void)didFinishWithData:(NSData *)data;
- (void)didFailWithError:(NSError *)error;
@end

typedef void(^KURLConnectionSuccessHandler)(NSData * data);
typedef void(^KURLConnectionFailedHandler)(NSError*);

@protocol KURLConnectionProtocol <NSObject>
@required
+ (void)startWithRequest:(NSURLRequest *)request successHandler:(KURLConnectionSuccessHandler)successHandler failedHandler:(KURLConnectionFailedHandler)failedHandler;
+ (void)startWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password successHandler:(KURLConnectionSuccessHandler)successHandler failedHandler:(KURLConnectionFailedHandler)failedHandler;
- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<KURLConnectionDelegate>)delegate;
- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<KURLConnectionDelegate>)delegate username:(NSString *)username andPassword:(NSString *)password;
- (void)start;

+ (NSURLRequest *)createGetRequestForUrl:(NSURL *)url;
+ (NSURLRequest *)createPostRequestForUrl:(NSURL *)url withJSONData:(NSData *)jsonData;

@end

@interface KURLConnection : NSObject <KURLConnectionProtocol>

@end
