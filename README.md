# ZDCoverTipView

ZDCoverTipView create a guide view easily.


## Features

* esay to use
* without UE image
* light weight
* no ios version limit

## Examples

The repo includes the following example projects that can be used as templates or for testing purposes
* RevealTableViewCellExample.xcodeproj

![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage0.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage2.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage1.png)
    
![Image](https://raw.github.com/John-Lluch/SWRevealTableViewCell/master/SWRevealTableViewCellImage3.png)


## Requirements

* iOS 7.0 or later.
* Objective-C, ARC.

## Usage

The SWRevealTableViewCell repository attempts to provide an updated cocoaPods file and consistent tag versioning, but it is not actively updated on the cocoapods-specs repository.

The easiest way to install it is by copying the following to your project:
* SWRevealTableViewCell.h
* SWRevealTableViewCell.m

On your project:
* Initialize instances of SWRevealTableViewCell on your cellForRowAtIndexPath or register the SWRevealTableViewCell for use with you table view
* In cellForRowAtIndexPath set the dataSource and optionally the delegate for SWRevealTableViewCell instances.
* Implement the following two datasource methods to return an array of SWCellButtonItems
    - (NSArray*)leftButtonItemsInRevealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell 
    - (NSArray*)rightButtonItemsInRevealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell

## Basic API Description

Registering a SWRevealTableViewCell for use on your tableView

    [tableView registerClass:[SWRevealTableViewCell class] forCellReuseIdentifier:RevealCellReuseIdentifier];

Creating cell instances
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        SWRevealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RevealCellReuseIdentifier forIndexPath:indexPath];

        cell.dataSource = self;
        .
        .
    }

Providing button items

    - (NSArray*)rightButtonItemsInRevealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell
    {
        SWCellButtonItem *item1 = [SWCellButtonItem itemWithTitle:@"Delete" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
        {
            NSLog( @"Delete");
        }];
    
        item1.backgroundColor = [UIColor redColor];
        item1.tintColor = [UIColor whiteColor];
        item1.width = 75;
        
        return @[item1];
    }

Programmatic animation of left/right items. Position can be: `SWCellRevealPositionLeft`, `SWCellRevealPositionCenter`, `SWCellRevealPositionRight`

    - (void)setRevealPosition:(SWCellRevealPosition)revealPosition animated:(BOOL)animated;
	
Other methods are documented in the SWRevealTableViewCell.h header file.

## Release Notes

Release Notes are updated on the class main header file. Please see `SWRevealTableViewCell.h`

## License

Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>

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
