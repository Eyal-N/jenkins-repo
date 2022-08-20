mkdir -p  ~/Desktop/DirA
touch ~/Desktop/DirA/{1..5}.txt
cd ~/Desktop/DirA

for filename in *.txt; do
  echo "this is 1-5 DirA files" >> "$filename"
done
