namespace :package do
  desc "Clean Mac OS X extended file attributes"
  task :clean_attributes do
    `for i in $(ls -Rl@ | grep '^\t' | awk '{print $1}' | sort -u); do
      find . | xargs xattr -d $i 2>/dev/null;
     done
    `
  end
end