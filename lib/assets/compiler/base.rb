module Assets
	module Compiler
		class InvalidCompiler < NameError; end

		class Base
			attr_accessor :source_path, :destination_path, :staleness_checker

			def self.create(type, paths)
				begin
					klass = Assets::Compiler.const_get(type.to_s.capitalize)
				rescue NameError
					raise InvalidCompiler, "No compiler found for #{type}"
				end

				klass.new(paths)
			end

			def initialize(paths)
				self.source_path, self.destination_path = paths
				self.staleness_checker = Checker.new(self)
			end

			def compile!
				outdated_files.each do |file|
					destination_file = destination_for_file(file)
					FileUtils.mkdir_p(File.dirname(destination_file))
					compile_file(file, destination_file)
				end
			end

			def destination_for_file(file)
				relative_path = file.sub(source_path, '')	
				File.join(destination_path, relative_path)
			end

			private

			def outdated_files
				staleness_checker.outdated_files
			end

			def compile_file(file, destination_file)
				File.copy(file, destination_file)
			end
		end
	end
end

