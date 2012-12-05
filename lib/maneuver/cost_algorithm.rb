module Maneuver
  class CostAlgorithm
    class << self
      attr_accessor :cache
      
      def compute(from, to)
        0
      end
    
      def method_added(method)
        return unless method.to_sym == :compute
        self.send :define_singleton_method, :_sing_compute, self.method(method.to_sym)
        self.singleton_method_added(:_sing_compute)
      end

      def singleton_method_added(method)
        return if method.to_sym != :compute &&  
          method.to_sym != :_sing_compute
        internal = lambda do |from, to|
          self.cache ||= {}
          self.cache[[from, to]] ||= begin
            self.send :compute, from, to            
          end
        end
        self.send :define_singleton_method, :_compute, internal
      end
    end
  end
end