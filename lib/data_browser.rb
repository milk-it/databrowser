# DataBrowser
require 'digest/sha1'

module DataBrowser
  Models = []
  @@user_digest = nil

  class << self
    def should_auth
      @@user_digest
    end

    def digest(user, pass)
      Digest::SHA1.hexdigest(user.to_s + pass.to_s)
    end
  
    def set_user(user, pass)
      @@user_digest = digest(user, pass)
    end

    def auth(user, pass)
      @@user_digest if digest(user, pass) == @@user_digest
      false
    end

    def check_digest(digest)
      @user_digest == digest
    end
  end
end
