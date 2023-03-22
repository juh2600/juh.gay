#!/usr/bin/fish

# this should be run from top level of repo, e.g., `build/build.fish'
# (because the files/dirs referenced below are relative to top of repo)

set -x indir src/
set -x outdir doc/
set -x resources js css files
set -x nginx_files xslt
set -x nginx_files_target /tmp/nginx

# make clean
rm -rf $outdir
rm -rf $nginx_files_target

# duplicate directory structure
for subdir in (find src/ -type d)
	#echo ==\> $subdir
	set -x newsubdir (echo $subdir | sed 's ^src/ doc/ g')
	set -x cmd mkdir -p $newsubdir
	echo $cmd
	$cmd
	# also link in dir-specific css
	# joe you're gonna have no idea what this was for in like a week
	# you wanted to add styles to the /essays/ dir so you did this horrible shit instead of just...not
	set -x rawsubdir (echo $subdir | sed 's ^src/  g')
	set -x cmd ln -s (pwd)/css/$rawsubdir $newsubdir/.css
	echo $cmd
	$cmd
end

# process all markdown files
for infile in (find src/ -type f | grep '\.md$')
	#echo ==\> $infile
	#set -x outfile (echo $infile | sed 's ^src/ doc/ g; s \.md$ .html g')
	set -x outfile (echo $infile | sed 's ^src/ doc/ g')
	set -x cmd pandoc \
    --css="https://cdn.jtreed.org/css/core.css" --css="/css/tweaks.css" --template=build/pandoc-template.html \
    --wrap=none -t html -o /dev/stdout $infile
    #-o $outfile $infile
	echo $cmd
	$cmd | sed -Ee 's@<a (href=[^>]+://[^>]+>)@<a target=_blank \1@g' > $outfile # sed compels external links to open in new tabs
end

# link web resources into server-accessible space
for resource in $resources
	set -x cmd ln -s ../$resource $outdir
	echo $cmd
	$cmd
end

# link files that nginx wants but that shouldn't be served into /tmp lol this is bad
mkdir $nginx_files_target
for thing in $nginx_files
	set -x cmd ln -s (realpath $thing) $nginx_files_target
	echo $cmd
	$cmd
end
