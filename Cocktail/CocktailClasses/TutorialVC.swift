//
//  TutorialVCV.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit
import Photos
import AVKit


class TutorialVC: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    private var videoTableViewData = [AVPlayerItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.dataSource = self
        
    }
    @IBAction func addVedioAction(_ sender: UIControl) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    private func fetchVideos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = PHAsset.fetchAssets(with: .video, options: options)
        
        var videos = [AVPlayerItem]()
        result.enumerateObjects { (asset, index, _) in
            PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (avAsset, _, _) in
                guard let avAsset = avAsset else { return }
                let playerItem = AVPlayerItem(asset: avAsset)
                videos.append(playerItem)
            }
        }
        videoTableViewData = videos
        print(videoTableViewData)
        videoTableView.reloadData()
    }
}
extension TutorialVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for:indexPath)
        
        let playerItem = videoTableViewData[indexPath.row]
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = cell.contentView.bounds
        cell.contentView.layer.addSublayer(playerLayer)
        
        return cell
    }
}
extension TutorialVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension TutorialVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let videoURL = info[.mediaURL] as? URL else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }) { [weak self] (success, error) in
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
                if success {
                    self!.fetchVideos()
                    print("Success")
                } else {
                    print("Error saving video: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
}
