import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else { return }

        let decoder = JSONDecoder()

        network.performGet(url: url) { data in
            do {
                let repositories = try decoder.decode([Repository].self, from: data!)
                completion(repositories)
            } catch {
                print (error.localizedDescription)
            }
        }
    }
}
