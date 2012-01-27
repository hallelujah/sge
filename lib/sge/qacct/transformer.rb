require 'yaml'
module SGE
  module QAcct
    class Transformer

      def load_from_yaml_file(yaml_file, remove_file = false,&block)
        File.open(yaml_file,"r+") do |file|
          YAML.load_documents(file,&block)
        end
        File.unlink(yaml_file) if remove_file
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
        cmd
      end

    end
  end
end
