module SGE
  module JobHelpers

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        @attributes = []
      end
    end

    module ClassMethods

      def define_attributes(opts)
        @attributes ||= []
        opts.each do |k,v|
          @attributes.push(k)
          attr_accessor(v)
          alias_method k, v
          alias_method "#{k}=", "#{v}="
        end
        # If attributes changed reload attributes_path
        @attributes_path = nil
        @attributes
      end

      def attributes_path
        @attributes_path ||= @attributes.join('|')
      end

      def from_document(doc)
        instance = new
        doc.xpath('.//' + self::attributes_path ).each do |node|
          instance.send("#{node.name}=", node.text)
        end
        instance
      end
    end

  end
end
