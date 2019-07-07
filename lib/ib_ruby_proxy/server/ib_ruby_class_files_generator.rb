module IbRubyProxy
  module Server
    # Source code generator that interacts with {IbRubyClassSourceGenerator} and writes down the
    # actual files with the source for both Ruby classes representing IB classes and Ruby extensions
    # for these.
    class IbRubyClassFilesGenerator
      attr_reader :client_code_dir, :server_code_dir

      # @param [String] client_code_dir
      # @param [String] server_code_dir
      def initialize(client_code_dir:, server_code_dir:)
        @client_code_dir = client_code_dir
        @server_code_dir = server_code_dir

        import_ruby_classes
      end

      # Generate client files and server class extensions
      #
      # It will format the generated code with {https://github.com/ruby-formatter/rufo Rufo}.
      #
      # @see IbRubyClassSourceGenerator#ruby_class_source
      # @see IbRubyClassSourceGenerator#ib_class_extension_source
      def generate_all
        do_generate_all
        format_code
      end

      private

      def import_ruby_classes
        ruby_classes.each do |class_name|
          java_import "com.ib.client.#{class_name}"
        end
      end

      def ruby_classes
        @ruby_classes ||= IbRubyProxy.config['classes']
      end

      def do_generate_all
        ruby_classes.each do |class_name|
          generate_files class_name
        end
      end

      def generate_files(class_name)
        ib_class = Java::ComIbClient.const_get(class_name)
        generator = IbRubyClassSourceGenerator.new(ib_class,
                                                   namespace: 'IbRubyProxy::Client::Ib')

        file_name = "#{IbRubyProxy::Util::StringUtils.to_underscore(class_name)}.rb"
        generate_client_file(generator, file_name)
        generate_server_file(generator, file_name)
      end

      def generate_client_file(generator, file_name)
        target_file = File.join(client_code_dir, file_name)
        puts "Generating client file: #{target_file}..."
        File.open(target_file, 'w') { |file| file.write(generator.ruby_class_source) }
      end

      def generate_server_file(generator, file_name)
        target_file = File.join(server_code_dir, file_name)
        puts "Generating server file: #{target_file}..."
        File.open(target_file, 'w') { |file| file.write(generator.ib_class_extension_source) }
      end

      def format_code
        [server_code_dir, client_code_dir].each do |dir|
          puts "Formatting #{dir}..."
          system "rufo #{dir}"
        end
      end
    end
  end
end
