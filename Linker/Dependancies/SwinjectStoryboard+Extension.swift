//
//  SwinjectStoryboard+Extension.swift
//  Linker
//
//  Created by Hossam on 22/10/2023.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
  public class func setup() {
    if AppDelegate.dependencyRegistry == nil {
      AppDelegate.dependencyRegistry = DependencyRegistery(container: defaultContainer)
    }
    
    let dependencyRegistry: DependencyRegisteryProtocol = AppDelegate.dependencyRegistry
    
    func main() {
      dependencyRegistry.container.storyboardInitCompleted(RoomsViewController.self) { r, vc in

        let coordinator = dependencyRegistry.makeRootNavigationCoordinator(rootViewController: vc)

        AppDelegate.navigationCoordinator = coordinator
        
        let presenter = r.resolve(RoomsPresenterProtocol.self)!
        
        vc.configure(with: presenter,
                     navigationCoordinator: coordinator)
      }
    }
    main()
  }
}
