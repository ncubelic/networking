# networking
Simple networking with error handling

## How to use
1. Create Resource
``` swift
  let resource = Resource<String>(path: "/test-path", method: .POST)
  
```

2. Create NetworkManager
``` swift
  let networkManger = NetworkManager()
  networkManger.apiCall(for: resource) { result in
    switch result {
    case .success(let responseString): print("Decoded response data \(responseString)")
    case .failure(let errorReport): print("ErrorReport data \(errorReport.localizedDescription)")
    }
  }
```
