Dota2App
========

Ipad vs Iphone storyboards
========

iPad Storyboard: iPad storyboard uses a splitview controller, with a master and detail. The master is a tab bar controller which a nav controller and home screen consisting of a list of heroes. The detail is a seperate view that is populated with information about the hero selected from the master's table view. 

iPhone Storyboards: The iPhone storyboard works prodominatly from what is considered the master view on iPad. This time when you select a hero from the list the navigation controller that belongs to the master is used to push into the detail view controller, this leads to 2 significant considerations when working with universal

iPad Navigation: The iPad master view populates the detail view using the didSelectRowAtIndexPath tableview method call.
iPhone Navigation: The iPhone master view populates the detail view using a segue and as such the prepareForSegueWith call.


Universal Detail View Navigation: The abilities view (which is selected from the segments at the top of the nav bar) uses a push segue to navigate to another view in both storyboards and as such to handle this you'll only need to use the prepareForSegueWith.


