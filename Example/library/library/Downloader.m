#import "Downloader.h"

@interface Downloader()
@property(nonatomic, assign) id<DataDownloaderDelegate> theDelegate;
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSURLRequest *request;
@property (nonatomic, copy) DataDownloaderSuccessHandler successHandler;
@property (nonatomic, copy) DataDownloaderFailedHandler failedHandler;
@end

@implementation Downloader

+ (NSURLRequest *)createGetRequestForUrl:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    return request;
}

+ (NSURLRequest *)createPostRequestForUrl:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    return request;
}

+ (void)startDownloadWithRequest:(NSURLRequest *)request successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler
{
    [self startDownloadWithRequest:request username:nil andPassword:nil successHandler:successHandler failedHandler:failedHandler];
}

+ (void)startDownloadWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password successHandler:(DataDownloaderSuccessHandler)successHandler failedHandler:(DataDownloaderFailedHandler)failedHandler
{
    Downloader *downloader = [[Downloader alloc] initWithRequest:request username:username andPassword:password];
    [downloader setSuccessHandler:successHandler];
    [downloader setFailedHandler:failedHandler];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:downloader startImmediately:YES];
    
    if (!connection)
    {
        failedHandler(nil);
    }
}

- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<DataDownloaderDelegate>)delegate
{
    return [self initWithRequest:request andDelegate:delegate username:nil andPassword:nil];
}

- (id)initWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password
{
    return [self initWithRequest:request andDelegate:nil username:username andPassword:password];
}

- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<DataDownloaderDelegate>)delegate username:(NSString *)username andPassword:(NSString *)password
{
    self = [self init];
    
    if (self != nil)
    {
        self.request = request;
        self.theDelegate = delegate;
        self.data = [NSMutableData data];
        self.username = username;
        self.password = password;
    }
    
    return self;
}

- (void)startDownload
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
    
    if (!connection)
    {
        [self respondDidFailDownloadingWithErrorToDelegate:nil];
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential *credential = [NSURLCredential credentialWithUser:self.username
                                                             password:self.password
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.theDelegate != nil)
    {
        [self respondDidFailDownloadingWithErrorToDelegate:error];
    }
    
    if (self.failedHandler != nil)
    {
        self.failedHandler(error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.theDelegate != nil)
    {
        [self respondDidFinishDownloadingToDelegate:[NSData dataWithData:self.data]];
    }
    
    if (self.successHandler != nil)
    {
        self.successHandler([NSData dataWithData:self.data]);
    }

}

- (void) respondDidFinishDownloadingToDelegate: (NSData *) data
{
    if ([self.theDelegate respondsToSelector:@selector(didFinishDownloadData:)])
    {
        [(id)[self theDelegate] performSelector:@selector(didFinishDownloadData:) withObject:data];
    }
}

- (void) respondDidFailDownloadingWithErrorToDelegate: (NSError *) error
{
    if ([self.theDelegate respondsToSelector:@selector(didFailDownloadWithError:)])
    {
        [(id)[self theDelegate] performSelector:@selector(didFailDownloadWithError:) withObject:error];
    }
}

@end
