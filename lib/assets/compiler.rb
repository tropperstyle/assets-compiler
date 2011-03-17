require 'assets/compiler/checker'
require 'assets/compiler/base'
require 'assets/compiler/javascript'
require 'assets/compiler/plugin/rack'
require 'assets/compiler/plugin/rails'

module Assets
	module Compiler
		extend self

		attr_accessor :config, :compilers

		DEFAULTS = {
			:compilers => {},
			:always_check => false
		}

		def init!(options)
			self.config = options.reverse_merge(DEFAULTS)
			self.compilers = []

			config[:compilers].each do |key, paths|
				compilers << Base.create(key, paths)
			end

			Plugin::Rails.extend! if defined?(Rails) && config[:always_check]

			compile!
		end

		def compile!
			compilers.each(&:compile!)
		end
	end
end
