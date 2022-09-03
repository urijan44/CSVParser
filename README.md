# CSVParser

CSV Parser는 Bundle Path의 csv 파일을 파싱해서 [[String]] 형태로 반환 합니다

# Example
```swift
struct BusListRepository {
  private let parser = CSVParser()
  private let routesBundlePath = "Seoul_Bus_Routes"
  
  private func bundlePath() -> String {
    Bundle.main.path(forResource: routesBundlePath, ofType: "csv") ?? ""
  }
}

extension BusListRepository: BusListRepositoryInterface {
  func fetchBusList() -> AnyPublisher<[[String]], Error> {
    
    do {
      let result = try parser.parseBundle(bundlePath())
      return Just(result)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
      
    } catch let error {
      return Fail(error: error)
        .eraseToAnyPublisher()
    }
  }
}
```

# Step
- import CSVParser
- call parseBundle(_:)
