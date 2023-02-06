#!/usr/bin/fish

set -x indir src/
set -x outdir doc/
set -x resources js css files

# make clean
rm -rf $outdir

# duplicate directory structure
for subdir in (find src/ -type d)
	#echo ==\> $subdir
	set -x newsubdir (echo $subdir | sed 's ^src/ doc/ g')
	set -x cmd mkdir -p $newsubdir
	echo $cmd
	$cmd
end

# process all markdown files
for infile in (find src/ -type f | grep '\.md$')
	#echo ==\> $infile
	set -x outfile (echo $infile | sed 's ^src/ doc/ g; s \.md$ .html g')
	set -x cmd pandoc \
    --css="https://cdn.jtreed.org/css/core.css" --css="/css/tweaks.css" --template=build/pandoc-template.html \
    --wrap=none -t html -o /dev/stdout $infile
    #-o $outfile $infile
	echo $cmd
	$cmd | sed -Ee 's@<a (href=[^>]+://[^>]+>)@<a target=_blank \1@g' > $outfile # sed compels external links to open in new tabs
end

# link resources into server-accessible space
for resource in $resources
	set -x cmd ln -s ../$resource $outdir
	echo $cmd
	$cmd
end
