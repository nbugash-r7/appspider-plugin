require_relative 'message_builder'

module Appsider
  module Publisher
    class MessageBuilderFactory
      def self.create(build)
        case build.result
          when Result::SUCCESS
            Appspider::Publisher::SuccessMessageBuilder.new(build)
          when Result::UNSTABLE
            Appspider::Publisher::UnstableMessageBuilder.new(build)
          when Result::FAILURE
            Appspider::Publisher::FailureMessageBuilder.new(build)
          when Result::NOT_BUILT
            Appspider::Publisher::NotBuildMessageBuilder.new(build)
          else
            Appspider::Publisher::AbortedMessageBuilder.new(build)
        end
      end
    end
  end
end
