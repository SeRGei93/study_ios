//
//  ViewController.swift
//  ImageLinkTable
//
//  Created by Сергей Бушкевич on 6.07.21.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableContainer: UITableView!
    var imageVC: ImageViewController?
    
    let imagesPath: [String] = [
        "https://thumb.tildacdn.com/tild3262-6462-4633-b465-336535663264/-/cover/720x720/center/center/-/format/webp/2019-04-30_175040.jpg",
        "https://thumb.tildacdn.com/tild3033-6433-4463-b238-363232303364/-/cover/720x720/center/center/-/format/webp/noroot.jpg",
        "https://thumb.tildacdn.com/tild6363-3562-4563-b337-643766643234/-/cover/720x720/center/center/-/format/webp/1.jpg",
        "https://thumb.tildacdn.com/tild6332-3265-4436-a636-323461643033/-/cover/720x720/center/center/-/format/webp/noroot.png"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "image")
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesPath.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = imagesPath[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "image") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = cellName
        return cell
    }
    

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let vc = imageVC else { return }
        _ = vc.view
        
        DispatchQueue.global(qos: .background).sync {
            if let imageUrl = URL(string: self.imagesPath[indexPath.row]),
               let imageData = try? Data(contentsOf: imageUrl){
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    vc.imageView.image = image
                }
            }
        }
        
        navigationController?.show(vc, sender: nil)
    }

}

