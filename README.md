# iOS-annotation-click
演示annotation的点击事件处理


### 前述

- [高德官方网站申请key](http://id.amap.com/?ref=http%3A%2F%2Fapi.amap.com%2Fkey%2F).
- 阅读[参考手册](http://api.amap.com/Public/reference/iOS%20API%20v2_3D/).
- 工程基于iOS 3D地图SDK实现
- 运行demo请先执行pod install --repo-update 安装依赖库，完成后打开.xcworkspace 文件

### 使用方法
点击annotation

### 核心类/接口
| 类    | 接口  | 说明   | 版本  |
| -----|:-----:|:-----:|:-----:|
| ViewController | - (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation; | 创建annotationView | 4.6.0 |

### 核心实现
#### objective-c
- 添加手势事件
```
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    
    return nil;
}
```
#### swift
```
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
```
