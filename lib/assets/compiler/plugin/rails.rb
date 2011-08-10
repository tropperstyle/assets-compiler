# Taken from nex3 sass
module Assets
  module Compiler
    module Plugin
      module Rails

        def self.extend!
          # Rails >= 3.0
          if defined?(ActionController::Metal)
            require 'assets/compiler/plugin/rack'
            Rails.configuration.middleware.use(Assets::Compiler::Plugin::Rack)

          # Rails >= 2.3
          elsif defined?(ActionController::Dispatcher) && defined?(ActionController::Dispatcher.middleware)
            require 'assets/compiler/plugin/rack'
            ActionController::Dispatcher.middleware.use(Assets::Compiler::Plugin::Rack)

          else
            raise StandardError, 'This version of rails is not supported'
          end
        end

      end
    end
  end
end
