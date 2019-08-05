//
//  SummaryTable.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

	extension SummaryViewController: UITableViewDataSource {
		
		// MARK: - UITableViewDataSource
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let showArray = self.dictionaryForShowArrays![navigationItem.title!] {
                return showArray.count
            }
			return 0
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			var movie: Show?
			
            if let showArray = self.dictionaryForShowArrays![navigationItem.title!] {
                movie = showArray[(indexPath as NSIndexPath).row]
            }

			let cellReuseId = "cell"
			let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
			cell.textLabel?.text = movie?.title
			let popularity = Float((movie?.popularity!)!)
			cell.detailTextLabel?.text = "\(Constant.POPULARITY): \(String(popularity)) "
            let preImage = UIImage(named: Constant.IMAGE)
			cell.imageView?.image = preImage
			
			if let posterPath = movie?.posterPath {
				let _ = Request.getPosterImage(Request.ParameterValues.posterSizes[0], filePath: posterPath , { (imageData, error) in
					if let image = UIImage(data: imageData!) {
						DispatchQueue.main.async {
							cell.imageView!.image = image
							debugPrint("\(image)")
						}
					} else {
						print(error ?? "Error loading poster")
					}
				})
			}
			return cell
		}
	}
	
	extension SummaryViewController: UITableViewDelegate {
		
		// MARK: - UITableViewDataSource
        
		func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			
			let controller = storyboard!.instantiateViewController(withIdentifier: "Detail") as! ShowViewController
			
            if let showArray = self.dictionaryForShowArrays![navigationItem.title!] {
                controller.selectedMovie = showArray[(indexPath as NSIndexPath).row]
                
                let transition = CATransition() // Transition
                transition.duration = 2
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                navigationController!.pushViewController(controller, animated: true)
            }
        }
	}
	
	

