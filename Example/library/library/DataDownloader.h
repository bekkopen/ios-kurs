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
+ (void)startDownloadWithUrl:(NSURL *)url successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler;
+ (void)startDownloadWithUrl:(NSURL *)url username:(NSString *)username andPassword:(NSString *)password successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler;
- (id)initWithUrl:(NSURL *)url andDelegate:(id<DataDownloaderDelegate>)delegate;
- (id)initWithUrl:(NSURL *)url andDelegate:(id<DataDownloaderDelegate>)delegate username:(NSString *)username andPassword:(NSString *)password;
- (void)startDownload;
@end