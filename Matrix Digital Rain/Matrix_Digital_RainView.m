#import "Matrix_Digital_RainView.h"

@implementation Matrix_Digital_RainView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setupWebView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupWebView];
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    [super drawRect:rect];
    
    if (!_webView) {
        [self setupWebView];
    } else {
        _webView.frame = self.bounds;
    }
}

- (void)setupWebView {
    WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:webConfiguration];
    _webView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self addSubview:_webView];
    [self loadMatrixHTML];
}

- (void)loadMatrixHTML {
    NSString *htmlPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"matrix_screensaver" ofType:@"html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:htmlPath];
    [_webView loadFileURL:htmlURL allowingReadAccessToURL:htmlURL.URLByDeletingLastPathComponent];
}

- (void)setFrame:(NSRect)frameRect {
    [super setFrame:frameRect];
    if (_webView) {
        [_webView setFrame:frameRect];
    }
}

- (BOOL)hasConfigureSheet {
    return NO;
}

- (NSWindow *)configureSheet {
    return nil;
}

@end
