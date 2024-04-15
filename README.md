# Cache Mechanism for iOS Swift

## Cache Manager

The project includes a CacheManager mechanism to store images retrieved from the API in both memory and disk cache for efficient retrieval.

### Memory Cache

NSCache is used for in-memory caching. It stores image objects in memory with a key-value pair where the key is the image URL and the value is the UIImage object.

### Disk Cache

A cache dictionary is used for disk caching. It stores image data on the disk with the image URL as the filename. When an image is requested, the CacheManager checks if the image exists in the disk cache. If it does, the image data is read from the disk and converted into a UIImage object.

Here's an example of how to use the CacheManager:

```swift
// In the vc call
self.yourUIImageViewName.setImage(url: "Your_Image_Url_String")

