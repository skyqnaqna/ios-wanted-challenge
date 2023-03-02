//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Subin Kim on 2023/03/01.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  @IBOutlet weak var image5: UIImageView!

  private var imageViews: [UIImageView]!
  private let imageUrls = [
    "https://images.unsplash.com/photo-1676737830610-2cebe4843eca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2533&q=80",
    "https://images.unsplash.com/photo-1676920410907-8d5f8dd4b5ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2232&q=80",
    "https://images.unsplash.com/photo-1676765374032-57d90e318b8f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1677116719762-fd4f4c4b7e35?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1316&q=80",
    "https://images.unsplash.com/photo-1677012817243-d3d91db2e7d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2232&q=80",
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    imageViews = [image1, image2, image3, image4, image5, ]
  }


  @IBAction func loadImage(_ sender: UIButton) {
    imageViews[sender.tag].image = UIImage(systemName: "photo")
    let urlStr = imageUrls[sender.tag]

    imageViews[sender.tag].fetchImage(urlStr: urlStr)
  }

  @IBAction func loadAllImages(_ sender: UIButton) {
    for i in imageViews.indices {
      imageViews[i].image = UIImage(systemName: "photo")
      let urlStr = imageUrls[i]
      imageViews[i].fetchImage(urlStr: urlStr)
    }
  }

  @IBAction func clearAllImages(_ sender: UIButton) {
    imageViews.forEach {
      $0.image = UIImage(systemName: "photo")
    }
  }
}

extension UIImageView {
  func fetchImage(urlStr: String) {
    guard let url = URL(string: urlStr) else { return }

    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("data task error: \(error)")
        return
      }

      guard let res = response as? HTTPURLResponse,
            (200 ..< 300) ~= res.statusCode else {
        print("bad response")
        return
      }

      if let data = data {
        let image = UIImage(data: data)

        DispatchQueue.main.async { [weak self] in
          self?.contentMode = .scaleAspectFit
          self?.image = image
        }
      }
    }.resume()
  }
}
