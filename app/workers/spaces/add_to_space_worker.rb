module Spaces
  class AddToSpaceWorker
    include Sidekiq::Job

    sidekiq_options queue: :high_priority, retry: 10

    def perform(user_id, space_id)
      user  = User.find(user_id)
      space = Space.find(space_id)

      user.add_space(space)
    rescue StandardError => e
      ForemStatsClient.count("spaces.add_to_space", 1, tags: ["action:failed", "user_id:#{user.id}"])
      Honeybadger.notify(e)
    end
  end
end
