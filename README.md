# ZDCoverTipView

ZDCoverTipView create a guide view easily.


## Features

* esay to use
* without UE image
* light weight
* no ios version limit

## Examples
<!--

![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage0.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage2.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage1.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage3.png)

-->


## Requirements

* iOS 4.0 or later.
* Objective-C, ARC.

## Usage

improt
* ZDCoverTipView.h
* ZDCoverTipView.m


## how to use

Create a Tip View

    ZDCoverTipView *tip = [[ZDCoverTipView alloc] initWithBlurRadius:10.0f revealView:_button revealType:_typeSwitch.on?ZDRevealTypeOval:ZDRevealTypeRect];

show it
    
    [tip showInView:self.view];


## License

Copyright (c) 2014 zhuchao <nono0313@163.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
