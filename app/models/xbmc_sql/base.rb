module XbmcSql
  class Base < ActiveRecord::Base
    self.abstract_class = true

    establish_connection XbmcSql::DATABASE

    self.record_timestamps = false

    class << self
      attr_accessor :aliased_attrs
      @aliased_attrs = {}
    end

    def self.alias_attributes(attrs)
      @aliased_attrs = attrs
      attrs.each { |k, v| self.alias_attribute v, k }
    end

    def attributes
      super.inject({}) do |hash, kv|
        if aliased_attrs.keys.include? kv[0].to_sym
          hash[aliased_attrs[kv[0].to_sym].to_s] = kv[1].to_s
        else
          hash[kv[0]] = kv[1]
        end

        hash
      end
    end

  private

    def aliased_attrs
      self.class.aliased_attrs
    end

    def aliased_changes
      Hash[changes.map { |k, v| [(aliased_attrs[k.to_sym] || k).to_s, v] }]
    end

    def aliased_changed
      changed.map { |k| (aliased_attrs[k.to_sym] || k).to_s }
    end
  end
end
