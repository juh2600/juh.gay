#!/usr/bin/fish

# this should be run from top level of repo, e.g., `build/build.fish'
# (because the files/dirs referenced below are relative to top of repo)
# (idk if it really matters)

set -x indir src/
set -x outdir doc/
set -x resources js css files images
set -x nginx_files xslt
set -x nginx_files_target /tmp/nginx

set -x hash (git rev-parse --short HEAD) # use this for invalidating browser caches

# make clean
rm -rf $outdir
rm -rf $nginx_files_target

# duplicate directory structure
for subdir in (find src/ -type d)
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
# $rawfile represents the path to the file under ./src, ./doc, and most importantly, under / on the live site
for infile in (find src/ -type f | grep '\.md$')
	set -x rawfile (echo $infile | sed 's ^src/  g')
	set -x outfile (echo $infile | sed 's ^src/ doc/ g')
	set -x cmd pandoc \
		--template=build/pandoc-template.html \
		--css="https://cdn.jtreed.org/css/core.css" \
		--css="/css/tweaks.css?hash=$hash" \
		--css=".css/default.css?hash=$hash" \
		--metadata=filepath=$rawfile \
		--metadata=hash=$hash \
		--wrap=none -t html -o /dev/stdout $infile
	echo $cmd
	$cmd \
		| sed -Ee 's@<a (href=[^>]+://[^>]+>)@<a target=_blank \1@g' \
		| sed -Ee 's (https://img.shields.io/badge/[^"\' ]*)([0-9]{4})-([0-9]{2})-([0-9]{2})([^"\' ]*\.svg) \1\2--\3--\4\5 g' \
	> $outfile # sed compels external links to open in new tabs, and fixes hyphens in dates in badges
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
