module Slack
  module Messengers
    class NewComment
      MESSAGE_TEMPLATE = <<~TEXT.chomp.freeze
        Article: %<url>s
        Comment text: %<text>s
        ---
        Manage commenter - @%<username>s: %<internal_user_url>s
      TEXT

      def initialize(comment:)
        @comment = comment
        @article = comment.commentable
        @user = comment.user
      end

      def self.call(...)
        new(...).call
      end

      def call

        internal_user_url = URL.url(
          Rails.application.routes.url_helpers.admin_user_path(user),
        )

        message = format(
          MESSAGE_TEMPLATE,
          url: URL.article(article),
          text: comment.body_markdown.truncate(300),
          username: user.username,
          internal_user_url: internal_user_url,
        )

        puts message

        Slack::Messengers::Worker.perform_async(
          "message" => message,
          "channel" => ApplicationConfig['SLACK_CHANNEL'],
          "username" => "comment_bot",
          "icon_emoji" => ":writing_hand:",
        )
      end

      private

      attr_reader :comment, :article, :user
    end
  end
end
