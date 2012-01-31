require 'yaml'
module SGE
  module QAcct
    class Transformer

      def load_from_yaml_file(yaml_file, remove_file = false,&block)
        raise "A block must be given" unless block_given?
        SGE::Utils.read_file(yaml_file,remove_file) do |file|
          YAML.load_documents(file,&block)
        end
      end

      def transformer_file
        File.expand_path('../../../../utils/transform_to_yaml.sh',__FILE__)
      end

      def command(opts = {})
        file = opts[:file].to_s.strip
        if file.empty?
          raise "We need a file to dump the yaml"
        end
        cmd = opts[:cmd] || "echo"
        cmd << " | #{transformer_file} > #{file}"
        cmd << " &" unless opts[:blocking]
        cmd
      end

    end
  end
end
