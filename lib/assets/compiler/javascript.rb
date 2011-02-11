module Assets
	module Compiler
		class Javascript < Base
			
			private

			def compile_file(file, destination_file)
				source = Closure::Compiler.new.compile(File.open(file, 'r'))
				File.open(destination_file, 'w') { |f| f.write(source) }
			end
		end
	end
end

