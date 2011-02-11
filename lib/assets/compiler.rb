module Assets
	module Compiler
		extend self

		attr_accessor :config, :compilers

		DEFAULTS = {}

		def init!(options)
			self.config = options.reverse_merge(DEFAULTS)
			self.compilers = []

			config[:compilers].each do |key, paths|
				compilers << Base.create(key, paths)
			end

			compile!
		end

		def compile!
			compilers.each(&:compile!)
		end
	end
end