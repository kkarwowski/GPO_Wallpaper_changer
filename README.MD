# About

If your company has a specific wallpaper which is displayed on all PCs in Domain - this script will cycle those wallpapers every time its run. You can have also "extra" wallpaper thrown in which is outside of regular pool - for special occasions.

Script keeps alphabetical sequence. 

This script when run copies a new wallpaper `.JPG` to `C:\Windows\SYSVOL\sysvol\***\` which are
picked up by GPO script upon logging into PC/Laptop. It has a sequence built in of 0-(number of files in DIR) which is written to `do_not_delete.conf` ( text file ).


It is determined by alphabetical order. 
To schedule for example weekly change of wallpaper set up on AD server in Task Scheduler a new task to call this script every week.
I have placed a screenshot of Task Scheduler setup in this folder.


# Adding additional wallpaper files

If you want to add files - please change `$max_wallpaper_number` to desired number of file Minus 1. For 10 files it means 9. 
Then copy all the additional `.jpg` files to `$wallpapers_path` directory. Make sure they are below 1MB to speed up login for users.

# Decreasing number of wallpaper files

If decreeing number of files in the `$wallpapers_path` directory make sure you check number in [do_not_delete.conf](do_not_delete.conf) and change it accordingly
so it is not grater than `$max_wallpaper_number` otherwise script will fail. You can zero out and start sequence from beginning by changing it to 0. 
Make sure you save the file :) 


# Usage

This script is the best run with Task Scheduler on your DC - perhaps once every week or two? Please see [task_scheaduler.PNG](task_scheaduler.PNG) and [task_scheaduler_1.PNG](task_scheaduler_1.PNG) screenshots which show correct set up in Task Scheduler.


