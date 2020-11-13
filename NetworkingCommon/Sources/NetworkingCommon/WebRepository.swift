import Foundation
import RxSwift

public protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

public extension WebRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> Observable<Result<Value, ClientError>> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            
            return Observable<Result<Value, ClientError>>.create { observer -> Disposable in
                let task = session.dataTask(with: request) { (data, response, error) in
                    guard let data = data,
                          let value = try? JSONDecoder().decode(Value.self, from: data)
                    else { return observer.onNext(.failure(.undefined)) }
                    if error != nil {
                        return observer.onNext(.failure(.badRequest))
                    }
                    observer.onNext(.success(value))
                }
                
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
            
        } catch {
            return .just(.failure(.badRequest))
        }
    }
}
