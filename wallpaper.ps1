# VARIABLES 

# path to folder with all 8 wallpapers
# C:\Windows\SYSVOL\sysvol\***\
$wallpapers_path = "C:\**********************"
# name of the weekly wallpaper file 
$dst_file_name = "weeklydesktop.JPG"
# folder where non usual wallpaper can be placed 
$extra_folder = "C:\**************\extra"
# text file location which contains number of current wallpaper - DO NO DELETE
$text_file = "C:\****************\do_not_delete.conf"
# Destination folder which contains weeklydesktop.JPG file
# C:\Windows\SYSVOL\sysvol\***\
$dst_folder = "C:\********************\dst_folder"
# max number of wallpaper files. After this numer sequence will go back to 0. 
$max_wallpaper_number = [System.IO.Directory]::GetFiles("$wallpapers_path", "*.jpg").Count

#Returns list of all file names of wallpapers in wallpapers_path 
function All_Files_List {
    $directoryInfo = Get-ChildItem $wallpapers_path
    $Files_count = $directoryInfo.count 
    Write-Output "Nubmee of files" $Files_count
    $Global:List_Of_Wallpepers = Get-ChildItem $wallpapers_path | select Name
}

# Checking Extra Folder for file. If contains Jpg it will return Folder_Status True
function Check_Extra_Foler {
    $Global:Folder_Status = $false
    $directoryInfo = Get-ChildItem $extra_folder | Measure-Object
     If ($directoryInfo.count -eq 1) #
        { Write-Output "Found a File in extra folder"
        $Dir = get-childitem $extra_folder
        $List = $Dir | where {$_.extension -eq ".jpg"}
            If ($List.Count -gt 0) {Write-Output "Found a JPG" 
        }
        $Global:File_Name = Get-ChildItem -Path $extra_folder -Name -File
        $Global:Folder_Status = $true
    }
    Else {
        Write-Output "No file in extra folder"
        $Global:Folder_Status = $false
    }
}

# Copy file to dst_folder and rename it. Takes parameter of $file ( file name to copy) and $path_from ( path from which to copy the file)
function Copy_The_File {
    Param($file, $path_from)
    Write-Output "Copying file " $file
    $dst = Join-Path $dst_folder $dst_file_name
    $src = Join-Path $path_from $file
    Copy-Item -Path $src -destination $dst
}

# Delete file from extra folder. Takes paramenter of $file ( file name to delete ).
function Delete_File {
    Param($file)
    Write-Output "Deleting File form Extra Folder"
    $dst = Join-Path $extra_folder $file
    Remove-Item -Path $dst -Recurse
}

# Reads text file with sequence number and returns it as global variable $file_val ( it will contain number between 0 - 7 - represents 8 standard wallapper files in wallpaper_path directory)
function Read_Text_File {
    $Global:File_val = Get-Content -Path $text_file
}
# Writes to text file with sequence new number corrensponding to new wallpaper. Takes parameter $number. 
function Write_Text_File {
    param (
        $number
    )
    Write-Output "Writing to file"
    Set-Content -Path $text_file -Value $number
    Write-Output "Wrote to file"
}
# Main Function:
# 1. Checks if Extra folder has a .JPG file. 
# 2. If returned $Folder_Status is False then folder is empty of .JPG files and continiues with script.
# 3. Returns fils of all file names in wallpaper_path and reads text file with sequence.
# 4. If $File_val equals to $max_wallpaper_number ( currently 7 ), it means we are at the end of sequence 0-7 and we have to copy 0 file $List_Of_Wallpepers[0] (first file in sequence). 
# Then we manually write to Text file 0 number representig that first file was copied. 
# 5. If $File_val equals or is less of 6 we we add to that number ( n number ), copy file representing new file and write to text file new number ( n number).
# 6. If $Folder_Status if True - Extra folder has .JPG file. It gets copied to denstiantion folder and deleted from Extra folder. Program quits. 
function Main_Func {
    Check_Extra_Foler
    If ($Folder_Status -eq $false) {
        Write-Output "Extra Folder is empty, continiue with program"
        All_Files_List
        Read_Text_File
        # 
        If ($File_val -eq $max_wallpaper_number) 
            {Write-Output "Found maximum number in file -  $max_wallpaper_number"
            Copy_The_File $List_Of_Wallpepers[0].Name $wallpapers_path
            $List_Of_Wallpepers[0]
            Write_Text_File 0
            Write-Output "Done, new file copied"
            }
        # 
        Else {Write-Output "Less than $max_wallpaper_number"
            $n = [int]$File_val + 1
            Copy_The_File $List_Of_Wallpepers[$n].Name $wallpapers_path
            $str_n = [string]$n
            Write_Text_File $str_n
            Write-Output "Done, new file copied"
            }

    }
    Else { Copy_File $File_Name $extra_folder
        Delete_File $File_Name
        Write-Output "Extra Folder had a file - it was copied and program will terminate now"
    }
}

Main_Func
