//
//  ChatPageViewController.swift
//  Minnaz
//
//  Created by Apple on 03/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class ChatPageViewController: UIPageViewController {
  weak var tutorialDelegate: ChatPageViewControllerDelegate?

  fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
    
    if AsStudent == "0"{
        // The view controllers will be shown in this order
//        return [self.newColoredViewController("Message"),
//                self.newColoredViewController("Contact"),
//                self.newColoredViewController("RequestChat")]
        return [self.newColoredViewController("Message"),
                self.newColoredViewController("Contact")]
    }else{
        // The view controllers will be shown in this order
//        return [self.newColoredViewController("Message"),
//                self.newColoredViewController("ContactStudent"),
//                self.newColoredViewController("RequestChat")]
        return [self.newColoredViewController("Message"),
                self.newColoredViewController("ContactStudent")]
    }
    
    
    // The view controllers will be shown in this order
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    
    if let initialViewController = orderedViewControllers.first {
      scrollToViewController(initialViewController)
    }
    
    tutorialDelegate?.ChatPageViewController(self,
                                             didUpdatePageCount: orderedViewControllers.count)
  }

  /**
   Scrolls to the next view controller.
   */
  func scrollToNextViewController() {
    if let visibleViewController = viewControllers?.first,
      let nextViewController = pageViewController(self,
                                                  viewControllerAfter: visibleViewController) {
      scrollToViewController(nextViewController)
    }
  }
  func scrollToPreviewsViewController(indexCall : Int) {
    self.scrollToViewController(index : indexCall)
  }
  func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    //        pageControl.setSelectedSegmentIndex((pages as NSArray).index(of: pendingViewControllers.last), animated: true)
  }



  /**
   Scrolls to the view controller at the given index. Automatically calculates
   the direction.
   
   - parameter newIndex: the new index to scroll to
   */
  func scrollToViewController(index newIndex: Int) {
    if let firstViewController = viewControllers?.first,
      let currentIndex = orderedViewControllers.index(of: firstViewController) {
      let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
      let nextViewController = orderedViewControllers[newIndex]
      scrollToViewController(nextViewController, direction: direction)
    }
    
    if let firstViewController = viewControllers?.last,
      let currentIndex = orderedViewControllers.index(of: firstViewController) {
      let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .reverse : .reverse
      let nextViewController = orderedViewControllers[newIndex]
      scrollToViewController(nextViewController, direction: direction)
    }
  }

  fileprivate func newColoredViewController(_ color: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
      instantiateViewController(withIdentifier: "\(color)ViewController")
  }

  /**
   Scrolls to the given 'viewController' page.
   
   - parameter viewController: the view controller to show.
   */
  fileprivate func scrollToViewController(_ viewController: UIViewController,
                                          direction: UIPageViewControllerNavigationDirection = .forward) {
    setViewControllers([viewController],
                       direction: direction,
                       animated: true,
                       completion: { (finished) -> Void in
                        // Setting the view controller programmatically does not fire
                        // any delegate methods, so we have to manually notify the
                        // 'tutorialDelegate' of the new index.
                        self.notifyTutorialDelegateOfNewIndex()
    })
  }

  /**
   Notifies '_tutorialDelegate' that the current page index was updated.
   */
  fileprivate func notifyTutorialDelegateOfNewIndex() {
    if let firstViewController = viewControllers?.first,
      let index = orderedViewControllers.index(of: firstViewController) {
      tutorialDelegate?.ChatPageViewController(self,
                                               didUpdatePageIndex: index)
    }
  }
}

// MARK: UIPageViewControllerDataSource

extension ChatPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
      return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
      return nil
    }
    
    return orderedViewControllers[previousIndex]
    
    
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    guard orderedViewControllersCount != nextIndex else {
      return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
    
  }
  
}

extension ChatPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    notifyTutorialDelegateOfNewIndex()
  }
  
}

protocol ChatPageViewControllerDelegate: class {
  
  /**
   Called when the number of pages is updated.
   
   - parameter ChatPageViewController: the ChatPageViewController instance
   - parameter count: the total number of pages.
   */
  func ChatPageViewController(_ ChatPageViewController: ChatPageViewController,
                              didUpdatePageCount count: Int)
  
  /**
   Called when the current index is updated.
   
   - parameter ChatPageViewController: the ChatPageViewController instance
   - parameter index: the index of the currently visible page.
   */
  func ChatPageViewController(_ ChatPageViewController: ChatPageViewController,
                              didUpdatePageIndex index: Int)
  
}
