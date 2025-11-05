//
//  APIService.swift
//  ApiCall
//
//  Created by Arshad Shaik on 29/10/25.
//

import Foundation

class APIService {
    
    typealias GetCompletionHandler = (Result<[Post], Error>) -> Void
    typealias PostCompletionHandler = (Result<Post, Error>) -> Void
    
    func fetchPosts(url: String, completion: @escaping GetCompletionHandler) {
        // Create URL
        guard let url = URL(string: url) else {
            return
        }
        
        // Create URLSession data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is not nil
            guard let data = data else {
                let noDataError = NSError(domain: "No data", code: -1, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            // Decode JSON
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start task
        task.resume()
    }
    
    func createPost(url: String, post: Post, completion: @escaping PostCompletionHandler) {
        // Create URL
        guard let url = URL(string: url) else {
            return
        }
        
        // Prepare URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the Post object into JSON
        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for data
            guard let data = data else {
                let noDataError = NSError(domain: "No data", code: -1, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            // Decode response
            do {
                let createdPost = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(createdPost))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the task
        task.resume()
    }
    
    // MARK: - Using Async -
    func fetchPostsAsync(urlString: String) async throws -> [Post] {
        // Create URL
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Perform asynchronous network request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let posts = try JSONDecoder().decode([Post].self, from: data)
        
        return posts
    }
}
