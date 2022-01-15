

1. [DGBottomSheet](#DGBottomSheet)
2. [Requirements](#Requirements)
3. [Installation](#Installation)
4. [Usage](#Usage)

# DGBottomSheet
The lightest swift bottom sheet library


<div>
<img src="https://user-images.githubusercontent.com/34573243/149148650-16227608-d503-4239-aa35-5b31815fc2a1.gif" width=250 />
</div>

## Requirements
- iOS 12.0+
- Swift 5.5+
- Xcode 10.0+


## Installation

### SPM
```
File > Add Packages > https://github.com/donggyushin/DGBottomSheet
```

### CocoaPod
```
pod 'DGBottomSheet', :git => 'https://github.com/donggyushin/DGBottomSheet'
```

## Usage
```
func showBottomSheet() {
    let contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // You should give view height constraint anyway
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .white
        return view
    }()
    let vc = DGBottomSheet(view: contentsView)
    // Make sure animated false 
    self.present(vc, animated: false)
}

// You can also hide DGBottomSheet programmatically
let vc = DGBottomSheet(view: contentsView)
vc.hide()
```

