#import "KURLConnection.h"

@interface KURLConnection()
@property(nonatomic, assign) id<KURLConnectionDelegate> theDelegate;
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSURLRequest *request;
@property (nonatomic, copy) KURLConnectionSuccessHandler successHandler;
@property (nonatomic, copy) KURLConnectionFailedHandler failedHandler;
@end

@implementation KURLConnection

+ (NSURLRequest *)createGetRequestForUrl:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    return request;
}

+ (NSURLRequest *)createPostRequestForUrl:(NSURL *)url withParameterAsString:(NSString *)params
{
    NSData *postData = [[params stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding] dataUsingEncoding:NSASCIIStringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    return request;
}

+ (NSURLRequest *)createPostRequestForUrl:(NSURL *)url withJSONData:(NSData *)jsonData
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    return request;
}


+ (void)startWithRequest:(NSURLRequest *)request successHandler:(KURLConnectionSuccessHandler)successHandler failedHandler:(KURLConnectionFailedHandler)failedHandler
{
    [self startWithRequest:request username:nil andPassword:nil successHandler:successHandler failedHandler:failedHandler];
}

+ (void)startWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password successHandler:(KURLConnectionSuccessHandler)successHandler failedHandler:(KURLConnectionFailedHandler)failedHandler
{
    KURLConnection *downloader = [[KURLConnection alloc] initWithRequest:request username:username andPassword:password];
    [downloader setSuccessHandler:successHandler];
    [downloader setFailedHandler:failedHandler];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:downloader startImmediately:YES];
    
    if (!connection)
    {
        failedHandler(nil);
    }
}

- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<KURLConnectionDelegate>)delegate
{
    return [self initWithRequest:request andDelegate:delegate username:nil andPassword:nil];
}

- (id)initWithRequest:(NSURLRequest *)request username:(NSString *)username andPassword:(NSString *)password
{
    return [self initWithRequest:request andDelegate:nil username:username andPassword:password];
}

- (id)initWithRequest:(NSURLRequest *)request andDelegate:(id<KURLConnectionDelegate>)delegate username:(NSString *)username andPassword:(NSString *)password
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

- (void)start
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
    
    if (!connection)
    {
        [self respondDidFailWithError:nil];
    }
}


#pragma mark - NSURLConnectionDelegate

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential *credential = [NSURLCredential credentialWithUser:self.username
                                                             password:self.password
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([response respondsToSelector:@selector(statusCode)])
    {
        int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)
        {
            [connection cancel];
            NSDictionary *errorInfo
            = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                                                  NSLocalizedString(@"Server returned status code %d",@""),
                                                  statusCode]
                                          forKey:NSLocalizedDescriptionKey];
            NSError *statusError
            = [NSError errorWithDomain:@"kurlconnection"
                                  code:statusCode
                              userInfo:errorInfo];
            [self connection:connection didFailWithError:statusError];
        }
    } else {
        [self.data setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self respondDidFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self respondDidFinishWithData:[NSData dataWithData:self.data]];
}

- (void)respondDidFinishWithData:(NSData *)data
{
    if([self.theDelegate respondsToSelector:@selector(didFinishWithData:)])
    {
        [(id)[self theDelegate] performSelectorOnMainThread:@selector(didFinishWithData:) withObject:data waitUntilDone:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.successHandler([NSData dataWithData:self.data]);
    });    
}

- (void)respondDidFailWithError:(NSError *)error
{
    if ([self.theDelegate respondsToSelector:@selector(didFailWithError:)])
    {
        [(id)[self theDelegate] performSelectorOnMainThread:@selector(didFailWithError:) withObject:error waitUntilDone:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.failedHandler(error);
    });
}

@end
