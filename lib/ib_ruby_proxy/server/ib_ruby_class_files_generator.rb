module IbRubyProxy
  module Server
    class IbRubyClassFilesGenerator
      attr_reader :client_code_dir

      RUBY_CLASSES = %w(ComboLeg DeltaNeutralContract Contract Order)

      RUBY_CLASSES.each do |class_name|
        java_import "com.ib.client.#{class_name}"
      end

      def initialize(client_code_dir:)
        @client_code_dir = client_code_dir
      end

      def generate_all
        RUBY_CLASSES.each do |class_name|
          generate class_name
        end

        format_code
      end

      private

      def generate(class_name)
        ib_class = Java::ComIbClient.const_get(class_name)
        generator = IbRubyProxy::Server::IbRubyClassSourceGenerator.new(ib_class, namespace: 'IbRubyProxy::Client::Ib')

        target_file = ruby_file_for(class_name)
        puts "Generating #{target_file}..."
        File.open(target_file, 'w') { |file| file.write(generator.ruby_class_source) }
      end

      def ruby_file_for(class_name)
        file_name = "#{IbRubyProxy::Util::StringUtils.to_underscore(class_name)}.rb"
        File.join(client_code_dir, file_name)
      end

      def format_code
        puts "Formatting..."
        system "rufo #{client_code_dir}"
      end
    end
  end
end
