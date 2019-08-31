# networking
Simple networking with error handling

## How to use
1. Change API base path in Info.plist

2. Create Resource
``` swift
  let resource = Resource<String>(path: "/test-path", method: .POST)
```

3. Create NetworkManager and execute apiCall
``` swift
  let networkManger = NetworkManager()
  networkManger.apiCall(for: resource) { result in
    switch result {
    case .success(let responseString): 
      print("Decoded response data \(responseString)")
    case .failure(let errorReport): 
      print("ErrorReport data \(errorReport.localizedDescription)")
    }
  }
```

### Error handler
1. Create ErrorHandler and pass UIViewController to present an AlertController
``` swift
  let errorHandler = ErrorHandler(rootViewController: UIViewController())
  errorHandler.handle(errorReport)
```
