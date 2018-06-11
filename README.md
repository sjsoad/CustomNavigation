# CustomNavigation  

## This pod will help you to create and integrate custom navigation a little bit faster.  

### What should you do?  

### Remember: import module in each place where you want to use classes from this pod

**Installation:**  

pod 'CustomNavigation'  

**1. How to create custom animation with CustomNavigation pod**   

For that, you should create new empty file inherited from CustomAnimatedTransitioning, and import module of course.  
Should be something like this:  

`import UIKit`  
`import SKCustomNavigation`  

`class CustomFallAnimation: NSObject, CustomAnimatedTransitioning {`    

`var duration: TimeInterval`    
`var reverseTransition: Bool`    

`required init(duration: TimeInterval = 1, reverseTransition: Bool = false) {`    
`self.duration = duration`  
`self.reverseTransition = reverseTransition`  
`}`  

`// MARK: - UIViewControllerAnimatedTransitioning -`  

`func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {`  
`return duration`  
`}`  

`func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {`  
`write transition code here`  
`and don't forget to call animationFinished() when animation is finished. This method will change 'direction' of animation automatically`  
`}`  

**reverseTransition** - false value means that this is 'forward' navigation and vise versa

**2. Custom push and pop navigation**  

If you want to create custom push/pop navigation you should use NavigationController class for navigation controller object. This class already implements everything we need.
In case you already have your custom navigation controller, make sure it inherits from NavigationController class from this pod.  

`let navigationController = DefaultNavigationController(rootViewController: YourViewController)`
`window?.rootViewController = navigationController`

If you want to add interaction(when navigation controller recognizes right swipe gesture to perform back action) to navigation controller, you can do next:  

`navigationController.set(interactive: true)`  

And finaly make your UIViewController conform to protocol AnimationControllerProvider:  

`class MainMenuViewController: UIViewController, MainMenuInterface, AnimationControllerProvider {`  
`var animatedTransitioning: CustomAnimatedTransitioning? = CustomPushTransition()`  
`}`

NavigationController will take animation by itself and perform it.    

**3. Custom present and dismiss navigation**  

In this case, you should use DefaultTransitioningDelegate. DefaultTransitioningDelegate contains 2 properties:    

**animatedTransitioning** - this is your custom animation. This value can be nil, but you won't see any custom animation    
**interactionController** - any class that conforms to UIViewControllerInteractiveTransitioning. This value can be nil and you won't interact with UIViewController with help of gesture      

You already know how to create animation. As for interactor, you can inherit from UIPercentDrivenInteractiveTransition and write your custom interaction with the controller.  

Finally, when you will have your animation and, optionally, interactor, you need to do the following:  

Create a property of transitioningDelegate with custom animation, also you can set interactor while initing delegate, in case you have everything you need for that:  

`var transitioningDelegate = DefaultTransitioningDelegate(animatedTransitioning: CustomFallAnimation())`    

in my case, I will set interactor at that moment, when I will have a view controller that I want to present.  

`transitioningDelegate.interactionController = PanInteractionController(viewController: viewControllerToPresent)`    
  
Finally, set delegate to a view controller, that will be presented: 

`viewControllerToPresent.transitioningDelegate = transitioningDelegate`    
`viewController.present(viewControllerToPresent, animated: true, completion: nil)`  

**4. Custom presentation using UIPresentationController**  

DefaultPresentationController provides you properties for configuring width and vertical position of view that will be presented.  
You can create your own class that inherits from UIPresentationController and return an object of that class in a block. Example of using DefaultPresentationController:    

Create a variable of DefaultTransitioningDelegate with animation(optional), interactor(optional) and presentation controller provider(optional)  

`private var customTransitioningDelegate = DefaultTransitioningDelegate(presentationControllerProvider: {  
(presented, presenting, _) -> UIPresentationController? in  
let presentationController = DefaultPresentationController(presentedViewController: presented, presenting: presenting)  
presentationController.verticalPosition = .bottom  
return presentationController  
})`  

Set modalPresentationStyle .custom and transitioningDelegate to view controller that will be presented

`viewControllerToPresent.modalPresentationStyle = .custom`  
`viewControllerToPresent.transitioningDelegate = customTransitioningDelegate`    
`viewController.present(viewControllerToPresent, animated: true, completion: nil)`  
