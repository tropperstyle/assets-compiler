module Assets
	module Compiler
		class Checker
			attr_accessor :compiler

			def initialize(_compiler)
				self.compiler = _compiler
			end

			def outdated_files
				files.select do |file|
					compiled_file = compiler.destination_for_file(file)
					!File.exists?(compiled_file) || File.mtime(file) > File.mtime(compiled_file)
				end
			end

			private

			def files
				Dir.glob(File.join(compiler.source_path, '**', '*')).select { |f| File.file?(f) }
			end
		end
	end
end
