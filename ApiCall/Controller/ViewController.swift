//
//  ViewController.swift
//  ApiCall
//
//  Created by Arshad Shaik on 29/10/25.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    let apiService = APIService()
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getApi(_ sender: UIButton) {
        fetchApiAsync()
    }
    
    @IBAction func postApi(_ sender: UIButton) {
        postApi()
    }
    
    func fetchApi() {
        //        showLoader()
        let activity = defaultActivityIndicatorView()
        DispatchQueue.main.async {
            self.view.addSubview(activity)
            activity.center = self.view.center
            activity.startAnimating()
        }
        apiService.fetchPosts(url: Apis.posts.rawValue) { result in
            DispatchQueue.main.async {
                activity.stopAnimating()
            }
            //            self.hideLoader()
            switch result {
            case .success(let posts):
                print("Received \(posts.count) posts")
                print("First post title: \(posts.first?.title ?? "No title")")
                print("Title body: ", posts.first?.titleDescription ?? "")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func postApi() {
        let newPost = Post(title: "Hello", titleDescription: "Swift POST Example", userId: 1)
        
        apiService.createPost(url: Apis.posts.rawValue, post: newPost) { result in
            switch result {
            case .success(let responsePost):
                print("Post created successfully!")
                print("Title: \(responsePost.title)")
                print("ID: \(responsePost.userId)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchApiAsync() {
        Task {
            do {
                let posts = try await apiService.fetchPostsAsync(urlString: Apis.posts.rawValue)
                print("first title: ", posts.first?.title ?? "")
            } catch {
                print(error.localizedDescription)
            }

        }
    }
}
