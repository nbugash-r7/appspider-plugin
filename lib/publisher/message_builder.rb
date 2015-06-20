module Appspider
  module Publisher
    module MessageBuilder
      attr_reader :build
      attr_reader :status

      def build_message
        Message.new(message)
      end
      private
      def message
        msg = "#{build.full_display_name}-#{status}"
        instance = Java::jenkins::model::Jenkins.instance
        if instance and instance.root_url
          msg << "(a<href=\"#{instance.root_url.chomp('/')}/#{build.url}\">Open</a>"
        end
        msg
      end
    end
    class SuccessMessageBuilder
      include MessageBuilder
      def initialize(build)
        @build = build
        @status = 'Success'
      end
    end
    class UnstableMessageBuilder
      include MessageBuilder
      def initialize(build)
        @build = build
        @status = 'Unstable'
      end
    end
    class FailureMessageBuilder
      include MessageBuilder
      def initialize(build)
        @build = build
        @nstatus = '<b>FAILURE</b>'
      end

      def message
        msg = super
        items = build.change_set.items
        unless items.empty?
          msg << '<br>&emsp;change by '
          msg << items.map {|i|
            if i.respond_to? :author_name
              "@\"#{i.author_name}\""
            else
              "@#{i.author_full_name}"
            end
          }.uniq.join(' ')
        end
        msg
      end
    end

    class NotBuildMessageBuilder
      include MessageBuilder
      def initialize(build)
        @build = build
        @status = 'Not Built'
      end
    end

    class AbortedMessageBuilder
      include MessageBuilder
      def initialize(build)
        @build = build
        @status = 'ABORTED'
      end
    end


  end
end
