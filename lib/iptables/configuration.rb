require 'json'

module IPTables
  class Configuration

    def initialize(*args)
      @config_hash = {}
      args.each do |arg|
        case arg
        when Hash
          arg.each do |key, value|
            raise "duplicate key: #{key}" if @config_hash.has_key? key
            @config_hash[key] = value
          end
        else
          raise "don't know how to handle #{arg.inspect}"
        end
      end
    end

    def policy(in_policy = nil)
      @policy ||= nil
      return @policy unless @policy.nil?
      unless in_policy.nil?
        @policy = in_policy
        return @policy
      end
      raise 'missing policy' unless @config_hash.has_key? 'policy'
      @policy = IPTables::Tables.new(@config_hash['policy'], self)
    end

    def policy6(in_policy = nil)
      @policy6 ||= nil
      return @policy6 unless @policy6.nil?
      unless in_policy.nil?
        @policy6 = in_policy
        return @policy6
      end
      raise 'missing policy6' unless @config_hash.has_key? 'policy6'
      @policy6 = IPTables::Tables.new(@config_hash['policy6'], self)
    end

    def interpolations(in_interpolations = nil)
      @interpolations ||= nil
      return @interpolations unless @interpolations.nil?
      unless in_interpolations.nil?
        @interpolations = in_interpolations
        return @interpolations
      end
      @interpolations = IPTables::Interpolations.new(self.primitives)
    end

    def primitives(in_primitives = nil)
      @primitives ||= nil
      return @primitives unless @primitives.nil?
      unless in_primitives.nil?
        @primitives = in_primitives
        return @primitives
      end
      raise 'missing primitives' unless @config_hash.has_key? 'primitives'
      @primitives = IPTables::Primitives.new(@config_hash['primitives'])
    end

    def rules(in_rules = nil)
      @rules ||= nil
      return @rules unless @rules.nil?
      unless in_rules.nil?
        @rules = in_rules
        return @rules
      end
      raise 'missing rules' unless @config_hash.has_key? 'rules'
      @rules = IPTables::Tables.new(@config_hash['rules'], self)
    end

    def services(in_services = nil)
      @services ||= nil
      return @services unless @services.nil?
      unless in_services.nil?
        @services = in_services
        return @services
      end
      raise 'missing services' unless @config_hash.has_key? 'services'
      @services = IPTables::Services.new(@config_hash['services'])
    end

    def macros(in_macros = nil)
      @macros ||= nil
      return @macros unless @macros.nil?
      unless in_macros.nil?
        @macros = in_macros
        return @macros
      end
      raise 'missing macros' unless @config_hash.has_key? 'macros'
      @macros = IPTables::Macros.new(@config_hash['macros'])
    end

    def converge_firewall()
      policy_fw = self.policy
      rules_fw = self.rules
      policy_fw.merge(rules_fw)
      return policy_fw
    end
  end
end
