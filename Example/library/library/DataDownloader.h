#import <Foundation/Foundation.h>


@protocol DataDownloaderDelegate <NSObject>
@required
- (void)didFinishDownloadData:(NSData *)data;
- (void)didFailDownloadWithError:(NSError *)error;
@end


typedef void(^DataDownloaderSuccessHandler)(NSData * data);
typedef void(^DataDownloaderFailedHandler)(NSError*);

@protocol DataDownloader <NSObject>
@required
+ (void)startDownloadWithRequest:(NSURLRequest *)request successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler;
+ (void)startDownloadWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler;
- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<DataDownloaderDelegate>)delegate;
- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<DataDownloaderDelegate>)delegate username:(NSString *)username andPassword:(NSString *)password;
- (void)startDownload;

+ (NSURLRequest *)createGetRequestForUrl:(NSURL *)url;
+ (NSURLRequest *)createPostRequestForUrl:(NSURL *)url;

@end