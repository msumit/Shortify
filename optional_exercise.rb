class Buzgap

	undef_method :puts

	def initialize &blk				
		instance_eval(&blk) if block_given?
	end

	def hello_world!
		$stdout.print "Hello World!\n"
	end

  # def method_missing mth, *arg, &blk
  #   $stdout.print mth.to_s.split('_').map(&:capitalize).join(' ') 
  #   $stdout.print "\n"
  # end

end

Buzgap.new do 
  hello_world!
  puts 'aap'
end