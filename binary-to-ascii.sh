echo "Clearning output directory..."
rm -rf output/
echo "Output cleared."


## xargs for an easy way to trim the output
inputFiles=(`find input/* -name "*.stl" -type f`)

echo "Starting to parse (${#inputFiles[@]}) files..."

##For each file - if it is binary format, convert it, else ignore
find input/* -name "*.stl" -type f -exec sh -c '
  for f; do
    file --mime-type -b "$f" | grep -Eq "(binary|application/octet-stream)" &&
    ruby ./convertSTL/convertSTL.rb $f
  done
' sh {} +

mkdir output/
## move the *ascii* files to output directory
mv ./input/**ascii** ./output