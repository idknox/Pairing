module Clicker
  class BaseController < ApplicationController
    def sessions_repo
      sessions_repos.fetch(params[:location])
    end

    private

    def sessions_repos
      @_sessions_repos ||= {
        "boulder" => SessionRepo.new(pubsub, "boulder"),
        "denver" => SessionRepo.new(pubsub, "denver")
      }
    end

    def pubsub
      @_pubsub ||= PubSub.new
    end
  end
end