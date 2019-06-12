echo "Clearning output directory..."
rm -rf output/
echo "Output cleared."


#variable array of all files that match file extension stl
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
