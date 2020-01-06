# Read Input Variables
read -p "Enter Project Name: " setupName
read -p "Enter Project Version Number: " setupVersion
read -p "Enter Author Name: " setupAuthor
read -p "Enter Author Email Address: " setupEmail
read -p "Enter Short Description: " setupDescription
read -p "Enter Project URL: " setupUrl

# Set Directory Variables
dir=$(PWD) > /dev/null 2>&1
bin_dir=$dir"/bin"
package_dir=$dir"/"$setupName
old_name_project=`find * -type d -not -name "bin"`

# Remove bin folder if it already exists
[ -d $bin_dir ] && rm -R $bin_dir

# Check for missing directories
[ ! -d $bin_dir ] && mkdir $bin_dir

# Move old package to new package folder
[[ $old_name_project ]] && mv -v $dir"/"$old_name_project $package_dir
[ ! -d $package_dir ] && mkdir $package_dir

# Create setup.py
printf "import setuptools\nwith open(\"README.md\",\"r\") as fh:\n\tlong_description=fh.read()\nsetuptools.setup(\n\tname=\'$setupName\',\n\tversion=\'$setupVersion\',\n\tscripts=[\'bin/$setupName\'],\n\tauthor=\'$setupAuthor\',\n\tauthor_email=\'$setupEmail\',\n\tdescription=\'$setupDescription\',\n\tlong_description=long_description,\n\tlong_description_content_type=\"text/markdown\",\n\turl=\'$setupUrl\',\n\tpackages=setuptools.find_packages(),\n\tclassifiers=[\n\t\t\"Programming Language :: Python :: 3\",\n\t\t\"License :: OSI Approved :: MIT License\",\n\t\t\"Operating System :: OS Independent\",\n\t]\n)" > setup.py

# Create bin script
printf "#!/usr/bin/env python\nimport $setupName" > $bin_dir"/"$setupName
