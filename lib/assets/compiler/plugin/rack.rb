# Taken from nex3 sass
module Assets
	module Compiler
		module Plugin
			class Rack
				# The delay, in seconds, between update checks.
				# Useful when many resources are requested for a single page.
				# `nil` means no delay at all.
				#
				# @return [Float]
				attr_accessor :dwell

				# Initialize the middleware.
				#
				# @param app [#call] The Rack application
				# @param dwell [Float] See \{#dwell}
				def initialize(app, dwell = 1.0)
					@app = app
					@dwell = dwell
					@check_after = Time.now.to_f
				end

				# @param env The Rack request environment
				# @return [(#to_i, {String => String}, Object)] The Rack response
				def call(env)
					if @dwell.nil? || Time.now.to_f > @check_after
						Assets::Compiler.compile!
						@check_after = Time.now.to_f + @dwell if @dwell
					end
					@app.call(env)
				end
			end
		end
	end
end
