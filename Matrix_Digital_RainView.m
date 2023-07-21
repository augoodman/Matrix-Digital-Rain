#import "Matrix_Digital_RainView.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface Matrix_Digital_RainView ()

@end

@implementation Matrix_Digital_RainView

@synthesize configureSheet = _configureSheet;

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
    return YES;
}

- (NSWindow *)configureSheet {
    self.choosePhotoButton.enabled = NO;
    if (!_configureSheet) {
        if (![[NSBundle mainBundle] loadNibNamed:@"ConfigureSheet" owner:self topLevelObjects:nil]) {
            NSLog(@"Failed to load configure sheet.");
            NSBeep();
        }
    }
    return _configureSheet;
}

- (IBAction)chooseImage:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowedContentTypes = @[[UTType typeWithFilenameExtension:@"jpg"],
                                      [UTType typeWithFilenameExtension:@"png"],
                                      [UTType typeWithFilenameExtension:@"bmp"],
                                      [UTType typeWithFilenameExtension:@"gif"]];
    if ([openPanel runModal] == NSModalResponseOK) {
        NSURL *imageURL = openPanel.URL;
        [[NSUserDefaults standardUserDefaults] setURL:imageURL forKey:@"MatrixScreensaverImageURL"];
    }
}

- (IBAction)neoVisionCheckboxToggled:(id)sender {
    NSButton *checkbox = (NSButton *)sender;
    if (checkbox.state == NSControlStateValueOn) {
        self.choosePhotoButton.enabled = YES;
    } else {
        self.choosePhotoButton.enabled = NO;
    }
}

- (IBAction)okButtonPressed:(id)sender {
    // Your code here
}

- (IBAction)cancelButtonPressed:(id)sender {
    // Your code here
}

@end
