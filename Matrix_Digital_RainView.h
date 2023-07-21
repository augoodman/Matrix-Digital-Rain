#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface Matrix_Digital_RainView : ScreenSaverView

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak, readonly) IBOutlet NSWindow *configureSheet;
@property (weak) IBOutlet NSButton *useCustomImageButton;
@property (nonatomic, weak) IBOutlet NSButton *neoVisionCheckbox;
@property (nonatomic, weak) IBOutlet NSButton *choosePhotoButton;


- (IBAction)chooseImage:(id)sender;
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
