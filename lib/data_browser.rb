# DataBrowser
require 'digest/sha1'

module DataBrowser
  @@user_digest = nil
  @@models = []

  class << self
    def should_auth
      @@user_digest
    end

    def digest(user, pass)
      Digest::SHA1.hexdigest(user.to_s + pass.to_s)
    end
  
    def protect(user, pass)
      @@user_digest = digest(user, pass)
    end

    def auth(user, pass)
      @@user_digest if digest(user, pass) == @@user_digest
      false
    end

    def check_digest(digest)
      @user_digest == digest
    end

    # models configuration

    def models
      @@models
    end

    def models=(models)
      @@models = models if models.is_a?(Array)
    end
  end
end
