
// not yet checked if working 
@interface NSString (HashtagString){
  @property (nonatomic, strong) hashtag;
  - (NSString*) hashtag {
    return [NSString stringWithFormat:@"#%@", self];
  }

  - (void) hashtag:(NSString* newValue) {
    NSString* stringWithoutHashtag = [newValue stringByReplacingOccurencesOfString:@"#"
                                                                        withString:@""
                                                                           options:NSStringCompareOptions.LiteralSearch
                                                                             range:nil];
    self = stringWithoutHashtag;
  }
}
