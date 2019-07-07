RSpec.configure do |config|
  config.around(:example, :impersonator) do |example|
    Impersonator.recording(example.full_description) do
      example.run
      if Impersonator.current_recording&.record_mode?
        puts "WAITING SINCE RECORDING MODE?"
        sleep 5
      end
    end
  end
end
