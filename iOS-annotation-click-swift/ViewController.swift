//
//  ViewController.swift
//  iOS-annotation-click-swift
//
//  Created by shaobin on 2017/4/5.
//  Copyright © 2017年 autonavi. All rights reserved.
//

import UIKit


class ViewController: UIViewController, MAMapViewDelegate {
    
    var mapView : MAMapView!
    var coords : Array<CLLocationCoordinate2D> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCoordinates()
        
        self.mapView = MAMapView.init(frame: self.view.bounds)
        self.mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initCoordinates() {
        coords.append(CLLocationCoordinate2D.init(latitude: 39.992520, longitude: 116.336170))
        coords.append(CLLocationCoordinate2D.init(latitude: 39.998293, longitude: 116.352343))
        coords.append(CLLocationCoordinate2D.init(latitude: 40.004087, longitude: 116.348904))
        coords.append(CLLocationCoordinate2D.init(latitude: 40.001442, longitude: 116.353915))
        coords.append(CLLocationCoordinate2D.init(latitude: 39.989105, longitude: 116.353915))
        
        coords.append(CLLocationCoordinate2D.init(latitude: 39.989098, longitude: 116.360200))
        coords.append(CLLocationCoordinate2D.init(latitude: 39.998439, longitude: 116.360201))
        coords.append(CLLocationCoordinate2D.init(latitude: 39.979590, longitude: 116.324219))
        coords.append(CLLocationCoordinate2D.init(latitude: 39.978234, longitude: 116.352792))
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func onClick(tapGesture:UITapGestureRecognizer!) {
        NSLog("==== annotation clicked")
        let annoView : MAAnnotationView! = tapGesture.view as! MAAnnotationView
        
        if(self.mapView.selectedAnnotations == nil || self.mapView.selectedAnnotations.first == nil) {
            self.mapView.selectAnnotation(annoView.annotation, animated: true)
        } else {
            let anno : MAPointAnnotation! = annoView.annotation as! MAPointAnnotation
            if(anno == self.mapView.selectedAnnotations.first as! MAPointAnnotation?) {
                if(!annoView.isSelected) {
                    annoView.setSelected(true, animated: true)
                }
            } else {
                self.mapView.selectAnnotation(annoView.annotation, animated: true)
            }
        }
    }
    
    //MARK: - MAMapViewDelegate
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if (annotation.isKind(of: MAPointAnnotation.self))
        {
            let pointReuseIndetifier = "myReuseIndetifier"
            var annotationView:MAAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            if (annotationView == nil)
            {
                annotationView =  MAAnnotationView.init(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                annotationView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.onClick(tapGesture:))))
                let imge  =  UIImage.init(named: "userPosition")
                annotationView?.image =  imge
            }
            
            annotationView?.canShowCallout              = true
            
            return annotationView;
        }
        
        return nil;
    }
    
    func mapInitComplete(_ mapView: MAMapView!) {
        
        var arr = Array<MAPointAnnotation>.init()
        var i = 1
        for loc in coords {
            let anno = MAPointAnnotation.init()
            anno.coordinate = loc
            anno.title = String.init(format: "anno:%d", i)
            i += 1
            arr.append(anno)
        }
        self.mapView.addAnnotations(arr)
    }
}

