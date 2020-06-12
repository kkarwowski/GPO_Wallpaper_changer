# # # # # # # # # # # # # # # # # # # # # # # # # # # 
#                                                   # 
#           Wallpaper changing script                # 
#                                                   # 
#           by Chris May 2020                       # 
#                                                   # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # 

This script when run copies a new wallpaper .JPG to 
C:\Windows\SYSVOL\sysvol\loncc.local\scripts\ which are
picked up by GPO script upon logging into PC/Laptop.
It has a sequence built in of 0-7 which is written to
Do_not_delete.conf ( text file ).  Here is a sequence:

Community.JPG - 0
Family.JPG - 1
Humility.JPG - 2
Integrity.JPG - 3
Learning.jpg - 4
Mission1.jpg - 5
Ownership.JPG - 6 
Respect.JPG - 7

It is determined by alphabetical order. 
To schedule for example weekly change of wallpaper set up on AD server in Task Scheduler a new task to call this script every week.
I have placed a screenshot of Task Scheduler setup in this folder.


ADDING ADDITIONAL WALLPAPER FILES

If you want to add files - please change $max_wallpaper_number to desired number of file MINUS 1. For 10 files it means 9. 
Then copy all the additional .jpg files to $wallpapers_path directory. Make sure they are below 1MB to speed up login for users.

DECRESING NUMBER OF WALLPAPER FILES

If decreeing number of files in the $wallpapers_path directory make sure you check number in do_not_delete.conf and change it accordingly
so it is not grater than $max_wallpaper_number otherwise script will fail. You can zero out and start sequence from beginning by changing it to 0. 
Make sure you save the file :) 
