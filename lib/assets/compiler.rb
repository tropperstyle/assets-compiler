module Assets
	module Compiler
		extend self

		attr_accessor :config, :compilers

		DEFAULTS = {
			:always_check => false,
			:compilers = {}
		}

		def init!(options)
			self.config = options.reverse_merge(DEFAULTS)
			self.compilers = []

			config[:compilers].each do |key, paths|
				compilers << Base.create(key, paths)
			end

			Plugin::Rails.extend! if defined?(RAILS_GEM_VERSION) && config[:always_check]

			compile!
		end

		def compile!
			compilers.each(&:compile!)
		end
	end
end
