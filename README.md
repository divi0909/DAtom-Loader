# DAtom-Loader
###Very Cool and lightweight atomic loader for iOS apps that can be customized with ease.###

![alt tag](http://idivi.esy.es/images/ezgif.com-resize%20(4).gif "Demo")
![alt tag](http://idivi.esy.es/images/ezgif.com-resize%20(3).gif "Demo")

##### Simply copy .h and .m file of DAtom Loader in your project and then import .h file in your view controller class in which you want to show loader.#####

To Show Loader first create instace of DAtom Loader in your .h file

````ruby
@property(strong,nonatomic) DAtomLoader *loader;
````
then initilize it by calling method
````ruby
_loader = [DAtomLoader sharedInstance];
````
######Note:- This loader is added on window not view so your transitions may affect while you are showing loader on window. remove loader from view before doing any transition.

Now to show loader simply call
````ruby
[_loader starAnimation:self.view];
// Replace your view self.view to show this loader
````
To stop loader simply call
````ruby
[_loader stopAnimation:self.view];
// Replace your view with self.view to remove loader 
// Also view must be same which is used to show loader to set all the settings of view in previous state after removing view
// default view.userInteractionEnabeled = No but you can change it in StarAnimation method of loader
````
Properties to customize in atomic loader are:

#####(1) Center Image of Atomic View(Default is blue color square image)#####

````ruby
  [loader setCenterImage:yourImage];
````
#####(2) Atom Image of Atomic View(Default is White color circle image)#####

````ruby
  [loader setAtomImage:yourImage];
````

#####(3) Atom Color of Atomic View(Default is white color circle image)#####
Note:-You can only change either image or color of atom because atom color is background color of images of atom so it won't show when you set an image on it.
````ruby
  [loader setAtomColor:yourColor];
````

Happy Coding... :)
